module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_reader :array_validate

    def validate(var, validation, params = nil)
      @array_validate ||= []
      @array_validate << { validation => { var: var, params: params } }
    end
  end

  module InstanceMethods
    def validate!
      self.class.array_validate.each do |validation|
        validation.each do |validation_name, args|
          send(validation_name, instance_variable_get("@#{args[:var]}".to_sym), args[:params])
        end
      end
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end
  end

  def presence(var, _plug)
    raise 'Не может быть пустым' if var.is_a?(String) && var.empty?
    raise 'Не может быть пустым' if var.nil?
  end

  def format(var, format)
    raise 'Неправильный формат' if var.to_s !~ format
  end

  def type(var, type)
    raise 'Неверный тип' unless var.is_a?(type)
  end
end
