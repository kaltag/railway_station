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

  def pass_train
    trains.each do |train|
      puts train if train.type == 'PASS'
    end
  end

  def gruz_train
    trains.each do |train|
      puts train if train.type == 'GRUZ'
    end
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
    stations.delete(station) if station != stations[0] && station != stations[-1]
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
    new_route.stations.first.add_train(self)
  end

  def move_next_station(route = self.route)
    route.stations.each_cons(2) do |station, next_staion|
      if station.trains.include?(self)
        station.delete_train(self)
        next_staion.add_train(self)
        break
      end
    end
  end

  def move_past_station(route = self.route)
    route.stations.reverse.each_cons(2) do |station, past_staion|
      if station.trains.include?(self)
        station.delete_train(self)
        past_staion.add_train(self)
        break
      end
    end
  end

  def current_station(route = self.route)
    route.stations.each do |station|
      if station.trains.include?(self)
        puts station.name
        break
      end
    end
  end

  def next_station(route = self.route)
    route.stations.each_cons(2) do |station, next_staion|
      if station.trains.include?(self)
        puts next_staion.name
        break
      end
    end
  end

  def past_station(route = self.route)
    route.stations.reverse.each_cons(2) do |station, past_staion|
      if station.trains.include?(self)
        puts past_staion.name
        break
      end
    end
  end

end
