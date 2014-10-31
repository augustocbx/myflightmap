Myflightmap::Application.routes.draw do

  # Indicate what action responds to "/" requests
  root 'home#index'

  # The import namespace uses non-standard routes. Set them up.
  namespace :import do
    root to: :index
    namespace :flight_memory do
      root to: :index
      post 'upload'
    end
  end

  get 'airports/search', to: 'airports#search'
  get 'airports/distance_between', to: 'airports#distance_between'
  get 'flights/duration', to: 'flights#duration'
  get 'audits/:type/:id', to: 'audits#index', as: 'audits'

  resources :flights, except: [:index]
  resources :trips, except: [:index]
  resources :airlines
  resources :airports, constraint: { id: /[A-Z]{3}/ }

  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  # Routes that are prefixed with the username
  # Ex) /mroach/map, /mroach/trips, /mroach/flights
  scope ':username' do
    get 'map', to: 'map#show'
    get 'flights(-:style)', to: 'flights#index', as: 'flightlist'
    patch 'flights/batch_update', to: 'flights#batch_update', as: 'flight_batch_update'
    get 'trips', to: 'trips#index', as: 'triplist'
    get 'trips/:id', to: 'trips#show', as: 'usertrip'
  end

end
