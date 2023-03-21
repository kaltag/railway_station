class PassengerTrain < Train
  attr_reader :train_type

  def initialize(train_number)
    super
    @train_type = 'Passenger'
  end
end
