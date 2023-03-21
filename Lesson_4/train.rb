class Train
  attr_reader :train_number, :route, :wagons
  attr_accessor :speed

  def initialize(train_number)
    @train_number = train_number
    @wagons = []
    @route
    @speed = 0
  end

  def add_wagons(wagon)
    @wagons << wagon if speed.zero? && wagon.wagon_type == train_type
  end

  def delete_wagons(wagon)
    @wagons.delete(wagon) if wagons.any? && speed.zero?
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

  # Добавил данные методы в protected, тк по ТЗ пользователь не может изменять скорость поезда, а следовательно у него нет доступа в этим методам
  # Почему private а не protected, тк сейчас у дочерних классов нет никаких методов для изменения скорости, то и доступ к ним остается только в том классе
  # если в дочерних будут изменения, то и тут станет protected

  private

  def speed_up
    self.speed += 10
  end

  def speed_down
    self.speed -= 10 if self.speed.positive?
  end
end
