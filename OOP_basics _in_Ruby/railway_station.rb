class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train)
    trains << train
  end

  def delete_train(train)
    trains.delete(train)
  end

  def train_by_type(type)
    trains.select { |n| n.type == type }
  end
end

class Route
  attr_reader :stations

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @stations = [@first_station, @last_station]
  end

  def add_station(station)
    stations.insert(-2, station)
  end

  def delete_station(station)
    stations.delete(station) unless [@first_station, @last_station].include?(station)
  end
end

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
    return if route.stations[-1] == route.stations[@current_station_index]

    route.stations[@current_station_index].delete_train(self)
    @current_station_index += 1
    route.stations[@current_station_index].add_train(self)
  end

  def move_past_station(route = self.route)
    return if route.stations[0] == route.stations[@current_station_index]

    route.stations[@current_station_index].delete_train(self)
    @current_station_index -= 1
    route.stations[@current_station_index].add_train(self)
  end

  def current_station(route = self.route)
    route.stations[@current_station_index].name
  end

  def next_station(route = self.route)
    route.stations[@current_station_index + 1].name unless route.stations[@current_station_index] == route.stations[-1]
  end

  def past_station(route = self.route)
    route.stations[@current_station_index - 1].name unless route.stations[@current_station_index] == route.stations[0]
  end
end
