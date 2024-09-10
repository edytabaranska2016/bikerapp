class TripsController < ApplicationController
  before_action :set_trip, only: %i[ show update destroy ]

  # GET /trips
  def index
    @trips = Trip.all

    render json: @trips
  end

  # GET /trips/1
  def show
    render json: @trip
  end

  # POST /trips
  def create
    @trip = Trip.new(trip_params)

    if @trip.save
      create_start_address_location
      create_destination_address_location
      render json: @trip, status: :created, location: @trip
    else
      render json: @trip.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /trips/1
  def update
    if @trip.update(trip_params)
      render json: @trip
    else
      render json: @trip.errors, status: :unprocessable_entity
    end
  end

  # DELETE /trips/1
  def destroy
    @trip.destroy!
  end

  private
  
  def set_trip
    @trip = Trip.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def trip_params
    params.require(:trip).permit(:start_address, :destination_address, :price, :date)
  end

  def create_start_address_location
    start_location = Location.new(address: trip_params[:start_address])
    start_location.save
  end

  def create_destination_address_location
    destination_location = Location.new(address: trip_params[:destination_address])
    destination_location.save
  end
end
