# service calculating weekly stats for current month
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
    total_distance = current_week_trips_scope.sum(:distance)

    "#{total_distance.round}km"
  end

  def calculated_total_price
    total_price = current_week_trips_scope.sum(:price)
    
    "#{total_price.round(2)}PLN"
  end
end
