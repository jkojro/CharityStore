class OrderMailer < ApplicationMailer
  default from: 'Janusz Kojro <habrafilm@gmail.com>'

  def received(order)
    @order = order

    mail to: order.email, subject: 'Potwierdzenie złożenia zamówienia w Charity store'
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.shipped.subject
  #
  def shipped(order)
    @gorder = order

    mail to: order.email, subject: 'Twój towar z Charity Store został wysłany'
  end
end
