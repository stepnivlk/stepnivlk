class ContactMailer < ApplicationMailer
  default from: "noreply@stepnivlk.net"
  default to: "tomas@stepnivlk.net"

  def new_message(message)
    @message = message

    mail subject: "Zpráva od #{message.name}"
  end
end
