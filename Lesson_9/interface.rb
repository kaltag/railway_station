class Interface
  MAIN_MENU_METHOD = { 1 => :case_station, 2 => :case_train, 3 => :case_route }.freeze
  CASE_STATION_METHOD = { 1 => :new_station, 2 => :all_stations, 3 => :all_trains_on_station }.freeze
  CASE_TRAIN_METHOD = { 1 => :new_train_menu, 2 => :add_wagon_menu, 3 => :delete_wagon, 4 => :all_wagon_menu,
                        5 => :take_place_menu, 6 => :route_train_menu, 7 => :go_next_menu, 8 => :go_back_menu }.freeze
  CASE_ROUTE_METHOD = { 1 => :new_route, 2 => :add_station_menu, 3 => :delete_station_menu }.freeze

  def start
    @stations = []
    @routes = []
    @cargo_trains = []
    @passenger_trains = []

    main_menu
  end

  def main_menu
    loop do
      puts '1 - Станции'
      puts '2 - Поезда'
      puts '3 - Маршуты'
      puts '0 - Выйти'

      key = gets.to_i
      MAIN_MENU_METHOD[key] ? send(MAIN_MENU_METHOD[key]) : break
    end
  end

  def case_station
    puts '1 - Создать новую станцию'
    puts '2 - Посмотреть список всех станций'
    puts '3 - Посмотреть список всех поездов на выбранной станции'

    key = gets.to_i
    send(CASE_STATION_METHOD[key]) if CASE_STATION_METHOD[key]
  end

  def case_train
    puts '1 - Создать новый поезд'
    puts '2 - Добавить вагон к поезду'
    puts '3 - Отцепить вагон от поезда'
    puts '4 - Посмотреть кол-во вагонов у поезда'
    puts '5 - Занять место в вагоне'
    puts '6 - Назначить маршут поезду'
    puts '7 - Переместить поезд на станцию вперед'
    puts '8 - Переместить поезд на станцию назад'

    key = gets.to_i
    send(CASE_TRAIN_METHOD[key]) if CASE_TRAIN_METHOD[key]
  end

  def case_route
    puts '1 - Создать новый маршут'
    puts '2 - Добавить станцию в маршут'
    puts '3 - Убрать станцию в маршуте'

    key = gets.to_i
    send(CASE_ROUTE_METHOD[key]) if CASE_ROUTE_METHOD[key]
  end

  private

  # Stations
  def new_station
    puts 'Введите имя станции'
    @stations << Station.new(gets.chomp)
  end

  def all_stations(stations = @stations)
    stations.each_with_index do |station, index|
      puts "Станция #{station.name} под номером #{index + 1}"
    end
  end

  def all_trains_on_station
    return if @stations.nil?

    all_stations
    puts 'Введите номер станции'
    input_station = gets.to_i - 1
    if @stations[input_station].nil?
      puts 'Такой станции не существует'
    else
      @stations[input_station].all_trains { |train| puts "Номер поезда: #{train.train_number}" }
    end
  end

  # Trains

  def new_train_menu
    showing_type_train
    case gets.to_i
    when 1
      new_cargo_train
    when 2
      new_passenger_train
    else
      puts 'Введены некорректные данные'
    end
  end

  def new_cargo_train
    puts 'Ввведите номер поезда в формате ххх-хх'
    @cargo_trains << CargoTrain.new(gets.chomp)
    puts "Создан грузовой поезд под номером#{@cargo_trains.last.train_number}"
  rescue StandardError => e
    puts e.message
    retry
  end

  def new_passenger_train
    puts 'Ввведите номер поезда в формате ххх-хх'
    @passenger_trains << PassengerTrain.new(gets.chomp)
    puts "Создан пассажирский поезд под номером:#{@passenger_trains.last.train_number}"
  rescue StandardError => e
    puts e.message
    retry
  end

  def add_wagon_menu
    showing_type_train
    case gets.to_i
    when 1
      add_cargo_wagon
    when 2
      add_passenger_wagon
    else
      puts 'Введены некорректные данные'
    end
  end

  def add_cargo_wagon
    choose_current_train(@cargo_trains)
    puts 'Введите объем вагона'
    input_volume = gets.to_i
    @current_train.add_wagons(CargoWagon.new(input_volume))
  end

  def add_passenger_wagon
    choose_current_train(@passenger_trains)
    puts 'Введите вместимость вагона'
    input_seats = gets.to_i
    @current_train.add_wagons(PassengerWagon.new(input_seats))
  end

  def delete_wagon_menu
    showing_type_train
    case gets.to_i
    when 1
      remove_wagon(@cargo_trains)
    when 2
      remove_wagon(@passenger_trains)
    else
      puts 'Введены некорректные данные'
    end
  end

  def all_wagon_menu
    showing_type_train
    case gets.to_i
    when 1
      check_all_wagon(@cargo_trains)
    when 2
      check_all_wagon(@passenger_trains)
    else
      puts 'Введены некорректные данные'
    end
  end

  def take_place_menu
    showing_type_train
    case gets.to_i
    when 1
      take_place_cargo
    when 2
      take_place_passenger
    else
      puts 'Введены некорректные данные'
    end
  end

  def take_place_cargo
    add_volume(@cargo_trains)
    input_wagon = gets.to_i
    puts 'Введите сколько объема вы хотите занять'
    puts "Свободно #{@current_train.wagons[input_wagon - 1].check_free_volume} едениц"
    volume = gets.to_i
    @current_train.wagons[input_wagon - 1].take_up_volume(volume)
  end

  def take_place_passenger
    add_volume(@passenger_trains)
    input_wagon = gets.to_i
    puts "Осталось свободных мест: #{@current_train.wagons[input_wagon - 1].check_free_seats}"
    @current_train.wagons[input_wagon - 1].take_seat
  end

  def route_train_menu
    showing_type_train
    case gets.to_i
    when 1
      add_route_train(@cargo_trains)
    when 2
      add_route_train(@passenger_trains)
    else
      puts 'Введены некорректные данные'
    end
  end

  def go_next_menu
    showing_type_train
    case gets.to_i
    when 1
      go_next_station(@cargo_trains)
    when 2
      go_next_station(@passenger_trains)
    else
      puts 'Введены некорректные данные'
    end
  end

  def go_back_menu
    showing_type_train
    case gets.to_i
    when 1
      go_past_station(@cargo_trains)
    when 2
      go_past_station(@passenger_trains)
    else
      puts 'Введены некорректные данные'
    end
  end

  def showing_type_train
    puts 'Выберите тип поезда'
    puts '1 - Грузовой'
    puts '2 - Пассажирский'
  end

  def showing_routes
    @routes.each_with_index do |route, index|
      puts "Маршут #{route.first_station.name} - #{route.last_station.name} под номером #{index + 1}"
    end
    puts 'Выберите номер маршута'
  end

  def choose_current_train(trains)
    trains.each_with_index do |train, index|
      puts "Поезд код:#{train.train_number} под номером - #{index + 1}"
    end
    puts 'Ввведите номер поезда'
    input_train = gets.to_i - 1
    @current_train = trains[input_train] unless trains[input_train].nil?
  end

  def remove_wagon(trains)
    choose_current_train(trains)
    @current_train.delete_wagons(@current_train.wagons.last)
  end

  def check_all_wagon(trains)
    choose_current_train(trains)
    @current_train.all_wagons { |_wagon, index| puts "Вагон номер #{index + 1}" }
  end

  def add_volume(trains)
    check_all_wagon(trains)
    puts 'Выберете номер вагона'
  end

  def add_route_train(trains)
    choose_current_train(trains)
    return if @routes.nil?

    showing_routes
    input_route = gets.to_i - 1
    @current_train.add_route(@routes[input_route]) unless @routes[input_route].nil?
  end

  def go_next_station(trains)
    choose_current_train(trains)
    puts "Поезд уехал с #{@current_train.current_station.name} в #{@current_train.next_station.name}"
    @current_train.move_next_station
  end

  def go_past_station(trains)
    choose_current_train(trains)
    puts "Поезд уехал с #{@current_train.current_station.name} в #{@current_train.past_station.name}"
    @current_train.move_past_station
  end

  # Route
  def new_route
    all_stations

    return if @stations.count < 1

    puts 'Введите номер первой станции'
    input_first_station = gets.to_i - 1

    puts 'Введите номер последней станции'
    input_last_station = gets.to_i - 1

    return if @stations[input_first_station].nil? && @stations[input_last_station].nil?

    @routes << Route.new(@stations[input_first_station], @stations[input_last_station])
  end

  def add_station
    if @routes.any?
      showing_routes
      add_station_to_route
    else
      puts 'Маршутов еще не создано'
    end
  end

  def add_station_to_route_menu
    input_route = gets.to_i - 1
    return if @routes[input_route].nil?

    current_route = @routes[input_route]
    other_stations = @stations - current_route.stations
    all_stations(other_stations)
    puts 'Введите номер станции'
    input_station = gets.to_i - 1
    current_route.add_station(other_stations[input_station]) unless other_stations[input_station].nil?
  end

  def delete_station_menu
    if @routes.any?
      showing_routes
      delete_station_to_route
    else
      puts 'Маршутов еще не создано'
    end
  end

  def delete_station_to_route
    input_route = gets.to_i - 1
    return if @routes[input_route].nil?

    current_route = @routes[input_route]
    all_stations(current_route.stations)

    puts 'Введите номер станции'
    input_station = gets.to_i - 1
    current_route.delete_station(current_route.stations[input_station])
  end
end
