require 'gcmap'
require 'geo'

class AirportsController < ApplicationController
  before_action :set_airport, only: %i(show edit update destroy update_from_external)

  # GET /airports
  # GET /airports.json
  def index
    @airports = policy_scope(Airport).order(:iata_code)
  end

  # GET /airports/1
  # GET /airports/1.json
  def show
    authorize @airport
  end

  # GET /airports/new
  def new
    @airport = Airport.new
    authorize @airport, :new?
  end

  # GET /airports/1/edit
  def edit
    authorize @airport, :edit?
    @timezones = TZInfo::Timezone.all_identifiers
  end

  # POST /airports
  # POST /airports.json
  def create
    authorize @airport, :create?
    @airport = Airport.new(airport_params)

    respond_to do |format|
      if @airport.save
        format.html { redirect_to @airport, notice: 'Airport was successfully created.' }
        format.json { render action: 'show', status: :created, location: @airport }
      else
        format.html { render action: 'new' }
        format.json { render json: @airport.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /airports/1
  # PATCH/PUT /airports/1.json
  def update
    authorize @airport, :update?
    respond_to do |format|
      if @airport.update(airport_params)
        format.html { redirect_to @airport, notice: 'Airport was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @airport.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /airports/1
  # DELETE /airports/1.json
  def destroy
    authorize @airport, :destroy?
    @airport.destroy
    respond_to do |format|
      format.html { redirect_to airports_url }
      format.json { head :no_content }
    end
  end

  # GET /airports/search?q=SEARCHTERM
  def search
    authorize :airport, :search?
    results = []
    results += Airport.where('iata_code LIKE ?', params[:q].upcase)
    results += Airport.where('LOWER(description) LIKE ?', "%#{params[:q].downcase}%")
    render json: results
  end

  # Update an airport's basic info from GCMap
  # Refresh name, city, country, description, timezone
  def update_from_external
    authorize @airport, :update_from_external?

    iata_code = params[:id].to_s.upcase

    # Load new data and existing airport
    @new_data = Gcmap.new.get_airport(iata_code)
    fields_to_update = %w(name city country description timezone)

    # Only permit updating certain fields and fields that changed value
    attributes = @new_data.attributes.select do |attr, value|
      fields_to_update.include?(attr.to_s) && @airport[attr] != value
    end
    logger.info "Updating airport #{@airport} with: #{attributes.inspect}"

    # Set audit comment so we know from whence the changes hath come
    attributes[:audit_comment] = 'Updated from GCMap'

    # And save the changes
    if @airport.update_attributes(attributes)
      redirect_to @airport, notice: 'Updated successfully'
    else
      redirect_to @airport, alert: 'Update failed'
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_airport
    @airport = Airport.find_by_iata_code!(params[:id].to_s.upcase)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def airport_params
    params.require(:airport).permit(:iata_code, :icao_code, :name, :city, :country, :latitude, :longitude, :timezone, :description)
  end
end
