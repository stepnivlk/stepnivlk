class MessagesController < ApplicationController
   def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    
    if @message.valid?
      ContactMailer.new_message(@message).deliver
      flash[:success] = "Vas mail byl odeslan"
      redirect_to root_path(anchor: "firstinfo")
    else
      flash[:danger] = "Vas mail nebyl odeslan, prosim zkuste to znovu."
      redirect_to root_path(anchor: "firstinfo")
    end
  end

private

  def message_params
    params.require(:message).permit(:name, :email, :content)
  end
end
