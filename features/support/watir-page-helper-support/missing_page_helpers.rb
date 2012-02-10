module MissingPageHelpers
  def self.included(cls)
    cls.extend ClassMethods
  end

  # A collection of class methods that generate helper methods that are mixed into a calling class.
  module ClassMethods
    def ol name, identifier=nil, &block
      define_method(name) do
        self.send("#{name}_ol").text
      end
      define_method("#{name}_items") do
        self.send("#{name}_ol").lis
      end
      create_element_getter "#{name}_ol", identifier, __method__, block
    end

  end

end
