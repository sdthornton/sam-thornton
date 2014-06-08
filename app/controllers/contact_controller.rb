class ContactController < ApplicationController

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    if @message.deliver
      flash[:success] = "Hooray!"
      redirect_to(contact_path)
    else
      flash[:alert] = "Something went wrong"
      render :new
    end
  end

  private

    def message_params
      params.require(:message).permit(:name, :email, :subject, :body)
    end

end
