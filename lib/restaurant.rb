class Restaurant
  attr_reader :id, :cooking_time, :long, :lat

  def initialize(id:, cooking_time: , x:, y:)

    @id = id
    @cooking_time = cooking_time
    @long = x
    @lat = y
  end
end