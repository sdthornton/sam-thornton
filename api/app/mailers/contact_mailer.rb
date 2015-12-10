class ContactMailer < ApplicationMailer

  def contact_message(message)
    @message = message
    mail(to: "mail@sam-thornton.com",
         from: @message.from,
         subject: @message.subject,
         body: @message.body,
         content_type: "text/html")
    end
  end

end
