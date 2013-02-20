require File.expand_path(File.join('..','helper'), __FILE__)

class TestPersistedClass < Test::Unit::TestCase
  def setup
    @riak_client = Riak::Client.new(YAML.load(File.read(File.join('..','riak.yml')))[:test])
    @ropl_master = Ropl.new @riak_client
  end

  def test_post
    @persisted_class = PersistedClass.new
    @persisted_class.attribute_one = 'post data'
    @persisted_class.attribute_two = 'other post data'

    response = @ropl_master.post @persisted_class
    assert response
  end

  def test_put
    @persisted_class = PersistedClass.new
    @persisted_class.key = 'put key'
    @persisted_class.attribute_one = 'put data'
    @persisted_class.attribute_two = 'other put data'

    response = @ropl_master.put @persisted_class
    assert_equal response, @persisted_class.key
  end

  def test_put_then_get
    @persisted_class = PersistedClass.new
    @persisted_class.key = 'put key'
    @persisted_class.attribute_one = 'put data'
    @persisted_class.attribute_two = 'other put data'

    @persisted_class = @ropl_master.get PersistedClass, 'put key'
    assert_equal 'put key',        @persisted_class.key
    assert_equal 'put data',       @persisted_class.attribute_one
    assert_equal 'other put data', @persisted_class.attribute_two
  end
end
