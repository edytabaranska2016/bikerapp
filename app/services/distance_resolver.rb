class DistanceResolver
  def initialize(trip)
    @trip = trip
  end

  def perform
    return 0 if locations_not_founded?

    Geocoder::Calculations.distance_between(start_coordinates(trip), destination_coordinates(trip))
  end

  private

  attr_reader :trip

  def start_coordinates(trip)
    start_location = Location.find_by(address: trip.start_address)
    
    start_location.nil? ? nil : [start_location.latitude,start_location.longitude]
  end

  def destination_coordinates(trip)
    destination_location = Location.find_by(address: trip.destination_address)

    destination_location.nil? ? nil : [destination_location.latitude,destination_location.longitude]
  end

  def locations_not_founded?
    start_coordinates(trip).nil? || destination_coordinates(trip).nil?
  end
end
