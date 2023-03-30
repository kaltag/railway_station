require_relative 'manufacturer_company'

class PassengerWagon
  include ManufacturerCompany

  attr_reader :wagon_type

  def initialize
    @wagon_type = 'Passenger'
  end
end
