class Shop

  attr_accessor :name, :phone, :address, :time

  def initialize(name, address, phone, time)
    @name = name
    @address = address
    @phone = phone
    @time = time
  end

end
