require_relative 'route'
require_relative 'station'
require_relative 'train'
require_relative 'train_cargo'
require_relative 'train_passenger'

s1 = Station.new("test1")
s2 = Station.new("test2")
s3 = Station.new("test3")

p1 = PassengerTrain.new(123, 10)
c1 = CargoTrain.new(987, 25)