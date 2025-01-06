class Api::V1::AdminsController < ApplicationController
  def index
    @admins = Admin.where(delete_flag: false)
    render json: @admins
  end

  def show
    @admin = Admin.find(params[:id])
    render json: @admin
  end

  def create
    @admin = Admin.new(admin_params)
    if @admin.save
      render json: @admin, status: :created
    else
      render json: @admin.errors, status: 422
    end
  end

  def update
    if @admin.update(admin_params)
      render json: @admin
    else
      render json: @admin.errors, status: 422
    end
  end

  def destroy
    @admin = Admin.find(params[:id])
    @admin.update(delete_flag: true)
    head :no_content
  end

  private

  def admin_params
    params.require(:admin).permit(:name, :admin_name, :password)
  end
end
