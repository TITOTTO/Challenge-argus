class Rider
  attr_reader :id, :speed, :long, :lat

  def initialize(id:, speed: , x:, y:)

    @id = id
    @speed = speed
    @long = x
    @lat = y
  end
end