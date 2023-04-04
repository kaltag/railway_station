class PassengerTrain < Train
  validate :train_number, :presence
  validate :train_number, :format, TRAIN_NUMBER_FORMAT
  validate :train_number, :type, String

  attr_reader :train_type

  def initialize(train_number)
    super
    @train_type = 'Passenger'
  end
end
