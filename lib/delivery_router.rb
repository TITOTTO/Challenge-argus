class DeliveryRouter
  attr_reader :restaurants, :customers, :riders
  attr_accessor :orders

  def initialize(restaurants, customers, riders)

    @restaurants = restaurants
    @customers = customers
    @riders = riders
    @orders = []
  end

  def add_order(customer:, restaurant:)
    orders << {customer_id: customer, restaurant_id: restaurant}
  end

  def clear_orders(customer:)
    orders.delete_if{|order| order[:customer_id] == customer}
  end
end