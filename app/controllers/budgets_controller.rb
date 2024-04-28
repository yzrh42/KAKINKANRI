class BudgetsController < ApplicationController
    def index
        @budgets = current_user.budgets.order(year: :asc, month: :asc)
        @monthly_balance = current_user.monthly_balance(Time.zone.now.year)
    end
    
    def new
        @budget = Budget.new
    end
    
    def create
        @budget = current_user.budgets.new(budget_params)
        # すでに同じ年月が存在するかどうかをチェック
        existing_budget = current_user.budgets.find_by(year: @budget.year, month: @budget.month)
        if existing_budget
            flash.now[:danger] = "#{existing_budget.year}年#{existing_budget.month}月はすでに登録されています"
            render :new
            return
        end
        if @budget.save
          redirect_to budgets_path, success: '登録しました'
        else
          flash.now[:danger] = '登録できませんでした'
          render :new
        end
    end

    def show
        @budget = Budget.find(params[:id])
    end

    def edit
        @budget = Budget.find(params[:id])
    end

    def update
        @budget = Budget.find(params[:id])
        existing_budget = Budget.find_by(year: @budget.year, month: @budget.month)
        if existing_budget
            flash.now[:danger] = "#{existing_budget.year}年#{existing_budget.month}月はすでに登録されています"
            render :new
            return
        end
        if @budget.update(budget_params)
          redirect_to budgets_path, success: '予算を更新しました'
        else
          flash.now[:danger] = '予算を更新できませんでした'
          render :edit
        end
    end
    
    def destroy
        @budget = Budget.find(params[:id])
        @budget.destroy!
        redirect_to budgets_path, success: '予算を削除しました'
    end
    
    private
    
    def budget_params
        params.require(:budget).permit(:year, :month, :amount, :user_id)
    end
end
