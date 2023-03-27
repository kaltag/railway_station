module ManufacturerCompany
  def create_name(name)
    self.company_name = name
  end

  def check_name
    company_name
  end

  protected

  attr_accessor :company_name
end
