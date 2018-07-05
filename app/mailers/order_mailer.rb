class OrderMailer < ApplicationMailer
  def order_confirmation(order)
    @order = order

    mail to: "order.address.eamil" subject: "Dziękuje za zamówienie"
  end

  def order_in_progress(order)
    @order = order

    mail to: "order.address.eamil" subject: "Zamówienie w realizacji"
  end

  def order_shipped(order)
    @order = order

    mail to: "order.address.eamil" subject: "Zamówienie wysłane"
  end

  def order_cancelled(order)
    @order = order

    mail to: "order.address.eamil" subject: "Zamówienie anulowane"
  end
end
