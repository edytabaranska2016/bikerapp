# service calculating monthly stats per day for current month
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
      next if trips_number(day).zero?

      stats_set = {
        day: formatted_day(day),
        total_distance: formatted_total_dostance(day),
        avg_ride: avg_ride(day),
        avg_price: avg_price(day)
      }

      stats_arr << stats_set
    end

    stats_arr
  end

  def calculated_total_distance_per_day(day)
    per_day_scope(day).sum(:distance).round
  end

  def formatted_total_dostance(day)
    "#{calculated_total_distance_per_day(day)}km"
  end

  def trips_number(day)
    per_day_scope(day).count
  end

  def avg_price(day)
    total_price = per_day_scope(day).sum(:price)

    avg_price = total_price / trips_number(day)
    "#{avg_price.round(2)}PLN"
  rescue ZeroDivisionError
    '0PLN'
  end

  def avg_ride(day)
    "#{calculated_total_distance_per_day(day) / trips_number(day)}km"
  rescue ZeroDivisionError
    '0km'
  end

  def formatted_day(day)
    full_date_splitted = day.to_formatted_s(:long_ordinal).split(' ')

    "#{full_date_splitted.first}, #{full_date_splitted[1].chop!}"
  end
end
