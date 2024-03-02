class HomesController < ApplicationController
  def index
    current_year = Time.current.year
    current_month = Time.current.month
    @budget = Budget.where(year: current_year, month: current_month).first
  end
end
