class Api::V1::UsersController < Api::V1::BaseController
  skip_before_action :authorize_request, only: [:login]
  before_action :authorize_user, except: [ :login ]

  def login
    user = User.find_by(user_name: params[:user_name])
    if user && user.password == params[:password]
      token = JsonWebToken.encode({ user_id: user.id, role: 'user', exp: 24.hours.from_now.to_i })
      render json: { token: token, user: user.as_json(except: [:password]) }, status: :ok
    else
      render json: { error: 'Không thể xác thực' }, status: :unauthorized
    end
  end
  def index
    @users = User.where(delete_flag: false)

    if @users
      @status_code = 0
      @custom_message = "Không có dữ liệu"
    else
      @status_code = 1
      @custom_message = "Lấy dữ liệu thành công"
    end
  end

  def show
    @user = User.find_by(id: params[:id], delete_flag: false)

    if @user
      @status_code = 1
      @custom_message = "Lấy dữ liệu thành công"
    else
      @status_code = 0
      @custom_message = "Lấy dữ liệu thất bại"
    end
  end

  def create
    @user = User.new(user_params)

    if user_params[:password_confirmation].nil?
      @status_code = 0
      @custom_message = "Vui lòng điền xác nhận mật khẩu"
    end

    if @user.save
      @status_code = 1
      @custom_message = "Tạo tài khoản thành công"
    else
      @status_code = 0
      @custom_message = "Tạo tài khoản thất bại"
      @error = @user.errors.full_messages
    end
  end

  def update
    @user = User.find_by(id: params[:id], delete_flag: false)

    if @user.nil? || @user.delete_flag
      @status_code = 0
      @custom_message = "Không tìm thấy User hoặc đã bị xóa"
      return
    end

    if user_params[:password_confirmation].nil?
      @status_code = 0
      @custom_message = "Cần nhập xác nhận mật khẩu"
    end

    if @user.update(user_params)
      @status_code = 1
      @custom_message = "Cập nhật thành công"
    else
      @status_code = 0
      @custom_message = "Cập nhật thất bại"
    end
  end

  def destroy
    @user = User.find_by(id: params[:id], delete_flag: false)
    if @user
      @status_code = 1
      @custom_message = "Xóa mềm thành công"
      @user.update(delete_flag: true)
    else
      @status_code = 0
      @custom_message = "Xóa thất bại"
    end
  end
  def user_params
    params.require(:user).permit(:name, :user_name, :password, :password_confirmation)
  end
end
