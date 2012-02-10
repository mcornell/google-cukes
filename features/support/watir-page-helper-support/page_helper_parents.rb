module PageHelperParents
  def self.included(cls)
    cls.extend ClassMethods
  end

  # A collection of class methods that generate helper methods that are mixed into a calling class.
  module ClassMethods

    private

    #overriding method from watir-page-helper gem to add :parent use instead of @browser every time.
    def create_element_getter name, identifier, type, block
      parent_name = identify_parent(identifier)
      define_method name do
        parent = self.send(parent_name.to_sym) unless parent_name.nil?
        parent ||= @browser
        if block
          block.arity == 1 ? block.call(self) : block.call
        else
          (identifier.nil? || identifier.length == 0) ? parent.send(type) : parent.send(type, identifier)
        end
      end
    end

    def identify_parent(identifier)
      if identifier.nil?
        return nil
      else
        return identifier.delete(:parent)
      end
    end
  end

end
