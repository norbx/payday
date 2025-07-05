class CategoriseController < ApplicationController
  def show
    @expenses = Expense.where(category_id: nil)
    @categories = Category.all
  end

  def create
    updates = JSON.parse(params[:expenses])

    if updates.any?
      Expense.upsert_all(updates, unique_by: :id)
      flash[:notice] = I18n.t("categorise.flash.success", count: updates.size)
    else
      flash[:alert] = I18n.t("categorise.flash.no_updates")
    end

    redirect_to categorise_path
  end
end
