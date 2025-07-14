class ImportsController < ApplicationController
  def index
  end

  def create
    return redirect_to(imports_path, notice: t("imports.flash.missing_file")) unless params[:csv_file].present?

    ImportExpenses.call(import_params[:csv_file], import_params[:csv_file].original_filename)

    redirect_to(imports_path, notice: t("imports.flash.success"))
  end

  private

  def import_params
    params.permit(:csv_file)
  end
end
