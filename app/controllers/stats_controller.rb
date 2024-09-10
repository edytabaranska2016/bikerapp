class StatsController < ApplicationController
  def weekly
    render json: WeeklyStatsResolver.new.perform
  end

  def monthly
    render json: MonthlyStatsResolver.new.perform
  end
end
