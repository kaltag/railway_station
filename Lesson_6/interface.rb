class Interface
  def start
    @stations = []
    @routes = []
    @cargo_trains = []
    @passenger_trains = []

    loop do
      puts '-----------------------------------------------------------------------------------------------------'
      puts '1 - Станции'
      puts '2 - Поезда'
      puts '3 - Маршуты'
      puts '0 - Выйти'

      input = gets.to_i
      case input
      when 1
        case_station
      when 2
        case_train
      when 3
        case_route
      else
        break
      end
    end
  end

  def case_station
    puts '-----------------------------------------------------------------------------------------------------'
    puts '1 - Создать новую станцию'
    puts '2 - Посмотреть список всех станций'
    puts '3 - Посмотреть список всех поездов на выбранной станции'
    input = gets.to_i
    case input
    when 1
      puts 'Введите имя станции'
      @stations << Station.new(gets.chomp)
    when 2
      @stations.each_with_index do |station, index|
        puts "Станция #{station.name} под номером #{index + 1}"
      end
    when 3
      if @stations.any?
        @stations.each_with_index do |station, index|
          puts "Станция #{station.name} под номером #{index + 1}"
        end
        puts 'Введите номер станции'
        input_station = gets.to_i - 1
        if @stations[input_station].nil?
          puts 'Такой станции не существует'
        else
          @stations[input_station].trains.each do |train|
            puts "Номер поезда: #{train.train_number}"
          end
        end
      else
        puts 'Станции еще не созданы'
      end
    end
  end

  def case_train
    puts '-----------------------------------------------------------------------------------------------------'
    puts '1 - Создать новый поезд'
    puts '2 - Добавить вагон к поезду'
    puts '3 - Отцепить вагон от поезда'
    puts '4 - Назначить маршут поезду'
    puts '5 - Переместить поезд на станцию вперед'
    puts '6 - Переместить поезд на станцию назад'
    input = gets.to_i
    case input
    when 1
      showing_type_train
      train_type = gets.to_i
      case train_type
      when 1
        begin
          puts 'Ввведите номер поезда в формате ххх-хх'
          @cargo_trains << CargoTrain.new(gets.chomp)
          puts "Создан грузовой поезд под номером#{@cargo_trains.last.train_number}"
        rescue StandardError => e
          puts e.message
          retry
        end
      when 2
        begin
          puts 'Ввведите номер поезда в формате ххх-хх'
          @passenger_trains << PassengerTrain.new(gets.chomp)
          puts "Создан пассажирский поезд под номером:#{@passenger_trains.last.train_number}"
        rescue StandardError => e
          puts e.message
          retry
        end
      else
        puts 'Введены некорректные данные'
      end
    when 2
      showing_type_train
      train_type = gets.to_i
      case train_type
      when 1
        choose_current_train(@cargo_trains)
        @current_train.add_wagons(CargoWagon.new)
      when 2
        choose_current_train(@passenger_trains)
        @current_train.add_wagons(PassengerWagon.new)
      else
        puts 'Введены некорректные данные'
      end
    when 3
      showing_type_train
      train_type = gets.to_i
      case train_type
      when 1
        remove_wagon(@cargo_trains)
      when 2
        remove_wagon(@passenger_trains)
      else
        puts 'Введены некорректные данные'
      end
    when 4
      showing_type_train
      train_type = gets.to_i
      case train_type
      when 1
        add_route_train(@cargo_trains)
      when 2
        add_route_train(@passenger_trains)
      else
        puts 'Введены некорректные данные'
      end

    when 5
      showing_type_train
      train_type = gets.to_i
      case train_type
      when 1
        go_next_station(@cargo_trains)
      when 2
        go_next_station(@passenger_trains)
      else
        puts 'Введены некорректные данные'
      end
    when 6
      showing_type_train
      train_type = gets.to_i
      case train_type
      when 1
        go_past_station(@cargo_trains)
      when 2
        go_past_station(@passenger_trains)
      else
        puts 'Введены некорректные данные'
      end
    end
  end

  def case_route
    puts '-----------------------------------------------------------------------------------------------------'
    puts '1 - Создать новый маршут'
    puts '2 - Добавить станцию в маршут'
    puts '3 - Убрать станцию в маршуте'
    input = gets.to_i

    case input
    when 1
      @stations.each_with_index do |station, index|
        puts "Станция #{station.name} под номером #{index + 1}"
      end
      if @stations.count > 1
        puts 'Введите номер первой станции'
        input_first_station = gets.to_i - 1
        if @stations[input_first_station].nil?
          puts 'Такой станции не существует'
        else
          first_station = @stations[input_first_station]
        end
        puts 'Введите номер последней станции'
        input_last_station = gets.to_i - 1

        if @stations[input_last_station].nil?
          puts 'Такой станции не существует'
        else
          last_station = @stations[input_last_station]
        end
        @routes << Route.new(first_station, last_station)
      else
        puts 'Станций меньше двух'
      end
    when 2
      if @routes.any?
        showing_routes
        input_route = gets.to_i - 1
        unless @routes[input_route].nil?
          current_route = @routes[input_route]
          other_stations = @stations - current_route.stations
          other_stations.each_with_index do |station, index|
            puts "Станция #{station.name} под номером #{index + 1}"
          end
          puts 'Введите номер станции'
          input_station = gets.to_i - 1
          current_route.add_station(other_stations[input_station]) unless other_stations[input_station].nil?
        end
      else
        puts 'Маршутов еще не создано'
      end
    when 3
      if @routes.any?
        showing_routes
        input_route = gets.to_i - 1
        unless @routes[input_route].nil?
          current_route = @routes[input_route]
          current_route.stations.each_with_index do |station, index|
            puts "Станция #{station.name} под номером #{index + 1}"
          end
          puts 'Введите номер станции'
          input_station = gets.to_i - 1
          current_route.delete_station(current_route.stations[input_station]) unless current_route[input_station].nil?
        end
      else
        puts 'Маршутов еще не создано'
      end
    end
  end

  private

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
      puts "Поезд код:#{train.train_number} под номером - #{index + 1}, вагонов: #{train.wagons.count}"
    end
    puts 'Ввведите номер поезда'
    input_train = gets.to_i - 1
    @current_train = trains[input_train] unless trains[input_train].nil?
  end

  def remove_wagon(trains)
    choose_current_train(trains)
    @current_train.delete_wagons(@current_train.wagons.last)
  end

  def add_route_train(trains)
    choose_current_train(trains)
    if @routes.any?
      @routes.each_with_index do |route, index|
        puts "Маршут #{route.first_station.name} - #{route.last_station.name} под номером #{index + 1}"
      end
      puts 'Выберите номер маршута'
      input_route = gets.to_i - 1
      @current_train.add_route(@routes[input_route]) unless @routes[input_route].nil?
    else
      puts 'Маршутов еще не создано'
    end
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
end
