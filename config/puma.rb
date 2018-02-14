# frozen_string_literal: true

def nprocessors
  case RbConfig::CONFIG['host_os']
  when /darwin/, /freebsd/
    `sysctl -n hw.physicalcpu`.to_i
  when /linux/
    `grep -c ^processor /proc/cpuinfo`.to_i
  else
    1
  end
end

workers ENV.fetch('PUMA_WORKERS', nprocessors).to_i

max_threads = ENV.fetch('PUMA_MAX_THREADS', 16).to_i
min_threads = ENV.fetch('PUMA_MIN_THREADS', max_threads).to_i
threads min_threads, max_threads

port = ENV.fetch('PUMA_PORT', '3000')
bind "tcp://0.0.0.0:#{port}"
preload_app!

# Don't wait for workers to finish their work. We might have long-running HTTP requests.
# But docker gives us only 10 seconds to gracefully handle our shutdown process.
# This settings tries to shut down all threads after 2 seconds. Puma then gives each thread
# an additional 5 seconds to finish the work. This adds up to 7 seconds which is still below
# docker's maximum of 10 seconds.
# This setting only works on Puma >= 3.4.0.
force_shutdown_after 2 if respond_to?(:force_shutdown_after)

on_worker_boot do
  ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
end

# As we are preloading our application and using ActiveRecord
# it's recommended that we close any connections to the database here to prevent connection leakage
# This rule also applies to any connections to external services (Redis, databases, memcache, ...)
# that might be started automatically by the framework.
before_fork do
  ActiveRecord::Base.connection_pool.disconnect! if defined?(ActiveRecord)
end
