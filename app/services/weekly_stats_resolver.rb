class WeeklyStatsResolver
  def perform
    { 
      total_distance: calculated_total_distance,
      total_price: calculated_total_price 
    }
  end

  private

  def current_week_trips_scope
    Trip.where(date: Date.today.beginning_of_week..Date.today.end_of_week)
  end

  def calculated_total_distance
    total_distance = 0
    current_week_trips_scope.each do |trip|
      geocoded_distance = ::DistanceResolver.new(trip).perform
      total_distance += geocoded_distance
    end

    "#{total_distance.round}km"
  end

  def calculated_total_price
    total_price = 0

    current_week_trips_scope.each do |trip|
      total_price += trip.price
    end

    "#{total_price.round(2)}PLN"
  end
end
