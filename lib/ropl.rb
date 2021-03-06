require 'riak'
require 'ropl/composition'

module Ropl
  class Ropl
    def initialize(riak_client)
      @riak_client = riak_client
    end

    def post(object)
      robject = Riak::RObject.new @riak_client.bucket(object.class.name)
      robject.content_type = 'application/x-marshalled-ruby-object'
      robject.raw_data = Marshal::dump(object)
      robject.store
    end

    def put(object, key)
      robject = Riak::RObject.new @riak_client.bucket(object.class.name), key.to_s
      robject.content_type = 'application/x-marshalled-ruby-object'
      robject.raw_data = Marshal::dump(object)
      robject.store.key
    end

    def get(klass, key)
      robject = @riak_client.bucket(klass.name).get(key.to_s)
      Marshal::load(robject.raw_data)
    end
  end
end
