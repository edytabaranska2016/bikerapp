class DistanceResolver
  def initialize(trip)
    @trip = trip
  end

  def perform
    Geocoder::Calculations.distance_between(start_coordinates(trip), destination_coordinates(trip))
  end

  private

  attr_reader :trip

  def start_coordinates(trip)
    start_location = Location.find_by(address: trip.start_address)
    [start_location.latitude,start_location.longitude]
  end

  def destination_coordinates(trip)
    destination_location = Location.find_by(address: trip.destination_address)
    [destination_location.latitude,destination_location.longitude]
  end
end
