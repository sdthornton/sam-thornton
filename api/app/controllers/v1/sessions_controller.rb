module V1
  class SessionsController < ApplicationController
    skip_before_action :authenticate_admin_from_token!

    def create
      @admin = Admin.find_for_database_authentication(email: params[:email])
      return invalid_login_attempt unless @admin

      if @admin.valid_password?(params[:password])
        sign_in :admin, @admin
        render json: @admin, serializer: SessionSerializer, root: nil
      else
        invalid_login_attempt
      end
    end

  private

    def invalid_login_attempt
      warden.custom_failure!
      render json: {error: t('sessions_controller.invalid_login_attempt')}, status: :unprocessable_entity
    end

  end
end
