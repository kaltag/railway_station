class CargoTrain < Train
  attr_reader :train_type

  def initialize(train_number)
    super
    @train_type = 'Cargo'
  end
end
