class Seed
  private_class_method :new
  
  def Seed.create(n, o)
    @@instances ||= {}
    @@instances[o] ||= new(n,o)
  end
  
  attr_reader :name, :attributes, :manual_attributes, :derived_attributes, :relationships, :headers
 
  def initialize(n, o)
    @name = n  
    @manual_attributes = o['headers']['attributes']['manual']
    @derived_attributes = o['headers']['attributes']['derived']
    @attributes = @manual_attributes + @derived_attributes
    @relationships = o['headers']['relationships']
    @headers = @attributes+@relationships
  end
 
end