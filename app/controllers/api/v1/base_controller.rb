module Api
  module V1
    class BaseController < ApplicationController
      before_action :authorize_request
      attr_reader :current_user, :current_admin

      private

      def authorize_request
        header = request.headers['Authorization']
        if header.present?
          token = header.split(' ').last
          begin
            @decoded = JsonWebToken.decode(token)
            assign_current_user_or_admin
          rescue JWT::DecodeError, JWT::ExpiredSignature
            render json: { errors: 'Token không hợp lệ hoặc đã hết hạn' }, status: :unauthorized
          rescue ActiveRecord::RecordNotFound
            render json: { errors: 'Tài khoản không tồn tại' }, status: :unauthorized
          end
        else
          render json: { errors: 'Authorization header không tồn tại' }, status: :unauthorized
        end
      end

      def assign_current_user_or_admin
        case @decoded[:role]
        when 'admin'
          @current_admin = Admin.find(@decoded[:admin_id])
        when 'user'
          @current_user = User.find(@decoded[:user_id])
        else
          render json: { errors: 'Role không hợp lệ' }, status: :unauthorized
        end
      end

      def authorize_admin
        render json: { errors: 'Access denied for non-admin users' }, status: :forbidden unless @current_admin
      end

      def authorize_user
        render json: { errors: 'Access denied for non-user accounts' }, status: :forbidden unless @current_user
      end
    end
  end
end
