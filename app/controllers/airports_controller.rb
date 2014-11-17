 require 'gcmap'
 require 'geo'

 class AirportsController < ApplicationController
  before_action :set_airport, only: [:show, :edit, :update, :destroy]

  # GET /airports
  # GET /airports.json
  def index
    @airports = Airport.all
  end

  # GET /airports/1
  # GET /airports/1.json
  def show
  end

  # GET /airports/new
  def new
    @airport = Airport.new
  end

  # GET /airports/1/edit
  def edit
    @timezones = TZInfo::Timezone.all_identifiers
  end

  # POST /airports
  # POST /airports.json
  def create
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
    @airport.destroy
    respond_to do |format|
      format.html { redirect_to airports_url }
      format.json { head :no_content }
    end
  end

  # GET /airports/search?q=SEARCHTERM
  def search
    results = []
    results += Airport.where("iata_code LIKE ?", params[:q])
    results += Airport.where("description LIKE ?", "%#{params[:q]}%")
    render json: results
  end

  # GET /airports/distance_between?from=CPH&to=LHR
  def distance_between
    from_airport = Airport.find_by iata_code: params[:from]
    to_airport = Airport.find_by iata_code: params[:to]
    render json: { distance: Geo.distance_between(from_airport.coordinates, to_airport.coordinates).to_i }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_airport
      iata_code = params[:id].to_s.upcase
      @airport = Airport.find_by(iata_code: iata_code)
      if @airport.nil?
        @airport = Gcmap.new.get_airport(iata_code)
        if @airport
          @airport.audit_comment = "Created by GCMap"
          @airport.save
        end
      end
      raise ActiveRecord::RecordNotFound if @airport.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def airport_params
      params.require(:airport).permit(:iata_code, :icao_code, :name, :city, :country, :latitude, :longitude, :timezone, :description)
    end
end
