require_relative 'instance_counter'
require_relative 'accessors'
require_relative 'validation'


class Station
  include InstanceCounter
  include Validation
  extend Accessors

  attr_accessor_with_history :name

  attr_reader :trains

  @@all_stations = []

  validate :name, :presence
  validate :name, :type, String

  def self.all
    @@all_stations
  end

  def initialize(name)
    @name = name
    @trains = []
    @@all_stations << self
    register_instance
    validate!
  end

  def all_trains(&block)
    @trains.each(&block)
  end

  def add_train(train)
    trains << train
  end

  def delete_train(train)
    trains.delete(train)
  end

  def train_by_type(type)
    trains.select { |train| train.type == type }
  end
end
