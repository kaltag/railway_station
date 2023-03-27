require_relative 'manufacturer_company'

class CargoWagon
  include ManufacturerCompany

  attr_reader :wagon_type

  def initialize
    @wagon_type = 'Cargo'
  end
end
