class Customer

  attr_reader :id, :long, :lat

  def initialize(id:, x:, y:)

    @id = id
    @long = x
    @lat = y
  end
end