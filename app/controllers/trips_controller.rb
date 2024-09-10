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
      update_distance_from_coordinates unless trip_params.include?(:distance)
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

  def trip_params
    params.permit(:start_address, :destination_address, :price, :date, :distance)
  end

  def create_start_address_location
    Location.create(address: trip_params[:start_address])
  end

  def create_destination_address_location
    Location.create(address: trip_params[:destination_address])
  end

  def calculated_distance
    ::DistanceResolver.new(@trip).perform
  end

  def update_distance_from_coordinates
    create_start_address_location
    create_destination_address_location
    @trip.update(distance: calculated_distance)
  end
end
