class HomesController < ApplicationController
  def index
    current_year = Time.current.year
    current_month = Time.current.month
    @budget = Budget.where(year: current_year, month: current_month).first
    @charges_this_month = Charge.where("date >= ? AND date <= ?", Time.current.beginning_of_month, Time.current.end_of_month).order(:date)
    @total_spent_this_month = @charges_this_month.sum(:amount)
    @remaining_budget = @budget.amount - @total_spent_this_month if @budget
    @charges_last_month = Charge.where("date >= ? AND date <= ?", Time.current.last_month.beginning_of_month, Time.current.last_month.end_of_month)
    @total_spent_last_month = @charges_last_month.sum(:amount)
    @difference_from_last_month = @total_spent_this_month - @total_spent_last_month
  end
end
