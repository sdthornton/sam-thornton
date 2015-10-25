class ApplicationController < ActionController::API
  include AbstractController::Translation

  # force_ssl if: :ssl_configured?

  before_action :authenticate_admin_from_token!

  respond_to :json

  def authenticate_admin_from_token!
    auth_token = request.headers['Authorization']
    if auth_token
      authenticate_with_auth_token auth_token
    else
      authentication_error
    end
  end

private

  def authenticate_with_auth_token(auth_token)
    return authentication_error unless auth_token.include?(':')

    admin_id = auth_token.split(':').first
    admin = Admin.where(id: admin_id).first

    if admin && Devise.secure_compare(admin.access_token, auth_token)
      sign_in admin, store: false
    else
      authentication_error
    end
  end

  def authentication_error
    render json: {error: t('unauthorized')}, status: 401
  end

end
