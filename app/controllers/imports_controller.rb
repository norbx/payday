class ImportsController < ApplicationController
  def index
  end

  def create
    redirect_to imports_path, notice: t("imports.flash.missing_file") unless params[:csv_file].present?
  end
end
