class Train
  attr_reader :train_number, :route, :number_of_wagons, :type
  attr_accessor :speed

  def initialize(train_number, type, number_of_wagons)
    @train_number = train_number
    @type = type
    @number_of_wagons = number_of_wagons
    @route
    @speed = 0
  end

  def speed_up
    self.speed += 10
  end

  def speed_down
    self.speed -= 10 if self.speed.positive?
  end

  def add_number_of_wagons
    @number_of_wagons += 1 if self.speed.zero?
  end

  def delete_number_of_wagons
    @number_of_wagons -= 1 if number_of_wagons.positive? && self.speed.zero?
  end

  def add_route(new_route)
    @route = new_route
    @current_station_index = 0
    new_route.stations[@current_station_index].add_train(self)
  end

  def move_next_station(route = self.route)
    return if next_station.nil?

    route.stations[@current_station_index].delete_train(self)
    @current_station_index += 1
    route.stations[@current_station_index].add_train(self)
  end

  def move_past_station(route = self.route)
    return if past_station.nil?

    route.stations[@current_station_index].delete_train(self)
    @current_station_index -= 1
    route.stations[@current_station_index].add_train(self)
  end

  def current_station
    route.stations[@current_station_index]
  end

  def next_station
    route.stations[@current_station_index + 1]
  end

  def past_station
    route.stations[@current_station_index - 1] unless route.first_station == current_station
  end
end
