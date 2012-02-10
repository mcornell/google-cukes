module MissingPageHelpers
  def self.included(cls)
    cls.extend ClassMethods
  end

  # A collection of class methods that generate helper methods that are mixed into a calling class.
  module ClassMethods
    def label name, identifier=nil, &block
      define_method(name) do
        self.send("#{name}_label").text
      end
      create_element_getter "#{name}_label", identifier, __method__, block
    end

  end

end
