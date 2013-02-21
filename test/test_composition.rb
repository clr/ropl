require File.expand_path(File.join('..','helper'), __FILE__)

class CompositeClass
  include Ropl::Composition
  attr_accessor :attribute_one, :attribute_two

  def initialize(attribute_one, attribute_two)
    @attribute_one = attribute_one
    @attribute_two = attribute_two
  end
end

class TestCompositeClass < Test::Unit::TestCase
  def setup
    riak_config = YAML.load(File.read(File.expand_path(File.join('..','riak.yml'), __FILE__)))[:test]
    riak_client = Riak::Client.new riak_config
    # set the persistence connection
    CompositeClass.ropl riak_client
  end

  def test_post
    # create some object without specifying the key
    composite_class = CompositeClass.new 'post data', 'other post data'

    # save it
    assert composite_class.persist
    assert !composite_class.key.nil?
  end

  def test_put
    # create some object with a key
    composite_class = CompositeClass.new 'put data', 'other put data'

    # set the key
    composite_class.key = 'put key'

    # save it
    response = composite_class.persist
    assert 'put key', response
  end

  def test_put_then_get
    # create some object with a key
    composite_class = CompositeClass.new 'put data', 'other put data'
    composite_class.key = 'put key'

    # save it
    composite_class.persist

    # get the object back
    composite_class = CompositeClass.retrieve 'put key'

    assert_equal 'put data',       composite_class.attribute_one
    assert_equal 'other put data', composite_class.attribute_two
  end
end
