module V1
  class ContactController < ApplicationController

    skip_before_action :authenticate_admin_from_token!

    def send
      @message = params[:message]
      ::ContactMailer.contact_message(@message).deliver_later
      render json: { hello: 'world' }
    end

  end
end
