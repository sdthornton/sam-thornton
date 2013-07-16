class ContactController < ApplicationController

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(params[:message])
    if @message.deliver
      flash[:success] = "Hooray!"
      redirect_to(contact_path)
    else
      flash[:alert] = "Something went wrong"
      render :new
    end
  end

end
