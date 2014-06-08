class Message
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations
  include ActionView::Helpers::TextHelper

  attr_accessor :name, :email, :subject, :body

  validates :name, :email, :subject, :body,
            presence: true

  validates :email,
            format: { with: /\A\S+@.+\.\S+\z/ }

  validates :body,
            length: { minimum: 10 }

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def deliver
    return false unless valid?
    Pony.mail({
      to: 'sam@sdthornton.com',
      from: %("#{name}" <#{email}>),
      reply_to: email,
      subject: subject,
      body: body,
      html_body: simple_format(body),
      via: :smtp,
      via_options: {
        openssl_verify_mode:  OpenSSL::SSL::VERIFY_NONE,
        address:              'mail.sdthornton.com',
        port:                 '587',
        enable_starttls_auto: true,
        user_name:            'sam@sdthornton.com',
        password:             '@4ozybm6@',
        authentication:       :plain,
        domain:               "sdthornton.com"
      }
    })
  end

  def persisted?
    false
  end
end
