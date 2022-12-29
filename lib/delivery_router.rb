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
    orders << {customer_id: customer, restaurant_id: restaurant, rider_id: nearest_rider(restaurant)}
  end

  def clear_orders(customer:)
    orders.delete_if{|order| order[:customer_id] == customer}
  end


  def route(rider:)
    order = orders.detect{|order| order[:rider_id] == rider}
    return [] if order.nil?

    [find_restaurant(order[:restaurant_id]), find_customer(order[:customer_id])]
  end

  def delivery_time(customer:)
    order = find_order(customer)
    restaurant = find_restaurant(order[:restaurant_id])
    rider = find_rider(order)
    client = find_customer(customer)
    rider_restaurant_dist = Math.sqrt(((restaurant.long - rider.long).abs)**2 + ((restaurant.lat - rider.lat).abs)**2)

    restaurant_customer_dist = Math.sqrt(((client.long - restaurant.long).abs)**2 + ((client.lat - restaurant.lat).abs)**2)
    binding.pry

    rider_restaurant_travel_time(restaurant, rider, rider_restaurant_dist) + ((60 * restaurant_customer_dist) / rider.speed)
  end

  private

  def rider_restaurant_travel_time(restaurant, rider, dist)
    return (60 * dist / rider.speed) if (60 * dist / rider.speed) > restaurant.cooking_time

    restaurant.cooking_time
  end

  def nearest_rider(restaurant_id)
    dist = 100000
    riders.each do |rider|
      rider_dist = (find_restaurant(restaurant_id).long - rider.long).abs + (find_restaurant(restaurant_id).lat - rider.lat).abs
      if dist > rider_dist
        dist = rider_dist
        @near_rider = rider.id
      end
    end
    @near_rider
  end

  def find_customer(customer_id)
    customers.detect{|customer| customer.id == customer_id}
  end

  def find_restaurant(restaurant_id)
    restaurants.detect{|restaurant| restaurant.id == restaurant_id}
  end

  def find_order(customer)
    orders.detect{|order| order[:customer_id] == customer}
  end

  def find_rider(order)
    riders.detect{|rider| rider.id == order[:rider_id]}
  end
end
