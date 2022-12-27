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
    [1, 2]
  end

  private

  def nearest_rider(restaurant_id)
    riders.each do |rider|
      dist = 100000
      actdist = (restaurants.detect{|restaurant| restaurant.id == restaurant_id}.long - rider.long).abs
      + (restaurants.detect{|restaurant| restaurant.id == restaurant_id}.lat - rider.lat).abs
      if dist > actdist
        dist = actdist
        @near_rider = rider.id
      end
    end
    @near_rider
  end
end
