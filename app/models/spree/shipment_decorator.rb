Spree::Shipment.class_eval do
  def billing_address
    order.bill_address
  end
  alias_method :bill_to, :billing_address

  def shipping_address
    order.ship_address
  end
  alias_method :ship_to, :shipping_address
end
