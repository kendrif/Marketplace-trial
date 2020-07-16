class OrderMailer < ApplicationMailer
  default from: 'Sam Ruby <orderio@example.com>'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.recived.subject
  #
  def recived(order)
    @order = order

    mail to: order.email, subject: 'Orderio confirmation '

  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.shipped.subject
  #
  def shipped
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
