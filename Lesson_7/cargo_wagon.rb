require_relative 'manufacturer_company'

class CargoWagon
  include ManufacturerCompany

  attr_reader :wagon_type, :overall_volume, :occupied_volume

  def initialize(overall_volume)
    @wagon_type = 'Cargo'
    @overall_volume = overall_volume
    @occupied_volume = 0
  end

  def take_up_volume(volume)
    @occupied_volume += volume if (occupied_volume + volume) < overall_volume
  end

  def check_free_volume
    overall_volume - occupied_volume
  end
end
