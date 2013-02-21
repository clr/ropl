module Ropl
  module Composition
    class Error < StandardError; end

    def self.included(base)
      base.extend(ClassMethods)
    end

    attr_accessor :ropl, :key

    def persist
      ropl = self.class.class_variable_get :@@ropl_object

      raise Error if ropl.nil?

      if @key.nil?
        @key = ropl.post self
      else
        ropl.put self, @key
      end
      @key
    end

    module ClassMethods
      def ropl(riak_client)
        self.ancestors[0].class_variable_set :@@ropl_object, Ropl.new(riak_client)
      end

      def retrieve(key)
        ropl = self.ancestors[0].class_variable_get :@@ropl_object
        raise Error if ropl.nil?
        ropl.get self.ancestors[0], key
      end
    end
  end
end
