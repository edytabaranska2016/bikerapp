class MonthlyStatsResolver
  def perform
    per_day_calculations
  end

  private

  def current_month_trips_scope
    @current_month_trips_scope ||= Trip.where(date: current_month_range)
  end

  def per_day_scope(calculation_day)
    current_month_trips_scope.where(date: calculation_day)
  end

  def current_month_range
    @current_month_range ||= Date.today.beginning_of_month..Date.today.end_of_month
  end

  def per_day_calculations
    stats_arr = []
    current_month_range.each do |day|
      next if trips_number(day) == 0

      stats_set = {
        day: day,
        total_distance: formatted_total_dostance(day),
        avg_ride: avg_ride(day),
        avg_price: avg_price(day)
      }

      stats_arr << stats_set
    end

    stats_arr
  end

  def calculated_total_distance_per_day(day)
    total_distance = 0
    per_day_scope(day).each do |trip|
      geocoded_distance = ::DistanceResolver.new(trip).perform
      total_distance += geocoded_distance
    end

    total_distance
  end

  def formatted_total_dostance(day)
    "#{calculated_total_distance_per_day(day).round}km"
  end

  def trips_number(day)
    per_day_scope(day).count
  end

  def avg_price(day)
    total_price = 0

    per_day_scope(day).each do |trip|
      total_price += trip.price
    end

    avg_price = total_price / trips_number(day)
    "#{avg_price.round(2)}PLN"
  rescue ZeroDivisionError
    "0PLN"
  end

  def avg_ride(day)
    "#{calculated_total_distance_per_day(day) / trips_number(day)}PLN"
  rescue ZeroDivisionError
    "0km"
  end
end
