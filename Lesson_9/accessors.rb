module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      name_history = "@#{name}_history"
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) do |value|
        array = instance_variable_get(name_history) || []
        array << instance_variable_get(var_name)
        instance_variable_set(name_history, array)
        instance_variable_set(var_name, value)
      end
      define_method("#{name}_history") { instance_variable_get(name_history) }
    end
  end

  def strong_attr_accessor(name, name_class)
    var_name = "@#{name}".to_sym
    define_method(name) { instance_variable_get(var_name) }
    define_method("#{name}=".to_sym) do |value|
      raise 'Не соответствие типов!' unless value.is_a? name_class

      instance_variable_set(var_name, value)
    end
  end
end
