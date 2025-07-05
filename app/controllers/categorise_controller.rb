class CategoriseController < ApplicationController
  def show
    @expenses = Expense.where(category_id: nil)
    @categories = Category.all
  end

  def create
    updates = JSON.parse(params[:expenses])

    if updates.any?
      Expense.upsert_all(updates, unique_by: :id)
      flash[:notice] = "Expenses categorized successfully."
    else
      flash[:alert] = "No expenses were submitted."
    end

    redirect_to categorise_path
  end
end
