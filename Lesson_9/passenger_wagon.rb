require_relative 'manufacturer_company'

class PassengerWagon
  include ManufacturerCompany

  attr_reader :wagon_type, :number_of_seats, :occupied_seats

  def initialize(number_of_seats)
    @wagon_type = 'Passenger'
    @number_of_seats = number_of_seats
    @occupied_seats = 0
  end

  def take_seat
    @occupied_seats += 1 if occupied_seats < number_of_seats
  end

  def check_free_seats
    number_of_seats - occupied_seats
  end
end
