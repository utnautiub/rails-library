class Api::V1::AdminsController < Api::V1::BaseController
  skip_before_action :authorize_request, only: [:login]
  before_action :authorize_admin, except: [:login]

  def login
    admin = Admin.find_by(admin_name: params[:admin_name])
    if admin && admin.password == params[:password]
      token = JsonWebToken.encode({ admin_id: admin.id, role: 'admin', exp: 24.hours.from_now.to_i })
      render json: { token: token, admin: admin.as_json(except: [:password]) }, status: :ok
    else
      render json: { error: 'Không thể xác thực' }, status: :unauthorized
    end
  end
  def index
    @admins = Admin.where(delete_flag: false)
    render json: @admins
  end

  def show
    @admin = Admin.find_by(id: params[:id], delete_flag: false)

    if @admin
      render json: @admin
    else
      render json: { errors: "Không tìm thấy Admin" }, status: 404
    end
  end

  def create
    @admin = Admin.new(admin_params)

    if admin_params[:password_confirmation].nil?
      render json: { errors: "Cần nhập xác nhận mật khẩu" }, status: 422
      return
    end

    if @admin.save
      render json: @admin, status: :created
    else
      render json: @admin.errors, status: 422
    end
  end

  def update
    @admin = Admin.find(params[:id])

    if @admin.nil? || @admin.delete_flag
      render json: { error: "Không tìm thấy Admin hoặc đã bị xóa" }, status: 404
      return
    end

    if admin_params[:password_confirmation].nil?
      render json: { errors: "Cần nhập xác nhận mật khẩu" }, status: 422
      return
    end

    if @admin.update(admin_params)
      render json: @admin
    else
      render json: @admin.errors, status: 422
    end
  end

  def destroy
    @admin = Admin.find(params[:id])

    if @admin.nil? || @admin.delete_flag
      render json: { error: "Không tìm thấy Admin hoặc đã bị xóa" }, status: 404
      return
    end

    if @admin.update(delete_flag: true)
      render json: { message: "Đã xóa thành công"}
    else
      render json: @admin.errors, status: 422
    end
  end

  private

  def admin_params
    params.require(:admin).permit(:name, :admin_name, :password, :password_confirmation)
  end
end
