require_relative 'manufacturer_company'
require_relative 'instance_counter'

class Train
  include ManufacturerCompany
  include InstanceCounter

  attr_reader :train_number, :train_route, :wagons
  attr_accessor :speed

  @@all_trains = []

  # три буквы или цифры, потом необязательный дефис, потом 2 буквы или цифры
  TRAIN_NUMBER_FORMAT = /\A[\w\d]{3}-?[\w\d]{2}\z/i.freeze

  def self.find(number)
    @@all_trains.find { |train| train.train_number == number }
  end

  def initialize(train_number)
    @train_number = train_number
    @wagons = []
    @train_route = 0
    @speed = 0
    @@all_trains << self
    register_instance
    validate!
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def add_wagons(wagon)
    @wagons << wagon if speed.zero? && wagon.wagon_type == train_type
  end

  def delete_wagons(wagon)
    @wagons.delete(wagon) if wagons.any? && speed.zero?
  end

  def all_wagons(&block)
    @wagons.each_with_index(&block)
  end

  def add_route(new_route)
    @train_route = new_route
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

  private

  def speed_up
    self.speed += 10
  end

  def speed_down
    self.speed -= 10 if self.speed.positive?
  end

  protected

  def validate!
    raise 'Введены некорректные данные номера поезда' if train_number !~ TRAIN_NUMBER_FORMAT
  end
end
