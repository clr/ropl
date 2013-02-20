require File.expand_path(File.join('..','helper'), __FILE__)

class TestPersistedClass < Test::Unit::TestCase
  def setup
    riak_config = YAML.load(File.read(File.expand_path(File.join('..','riak.yml'), __FILE__)))[:test]
    riak_client = Riak::Client.new riak_config
    @ropl       = Ropl::Ropl.new riak_client
  end

  def test_post
    # create some object without a key
    @persisted_class = PersistedClass.new
    @persisted_class.attribute_one = 'post data'
    @persisted_class.attribute_two = 'other post data'

    # save it
    response = @ropl.post @persisted_class
    assert response
  end

  def test_put
    # create some object with a key
    @persisted_class = PersistedClass.new
    @persisted_class.attribute_one = 'put data'
    @persisted_class.attribute_two = 'other put data'

    # save it
    response = @ropl.put @persisted_class, 'put key'
    assert_equal 'put key', response
  end

  def test_put_then_get
    # create some object with a key
    @persisted_class = PersistedClass.new
    @persisted_class.attribute_one = 'put data'
    @persisted_class.attribute_two = 'other put data'

    # save it
    @ropl.put @persisted_class, 'put key'

    # get the object back
    @persisted_class = @ropl.get PersistedClass, 'put key'
    assert_equal 'put data',       @persisted_class.attribute_one
    assert_equal 'other put data', @persisted_class.attribute_two
  end

  def test_a_thousand_ops
    # create a thousand objects
    objects = 1000.times.map do
      random_ascii = lambda{|n| rand(n).times.map{ rand(256).chr }.join }

      # create some object with a key
      @persisted_class = PersistedClass.new
      @persisted_class.attribute_one = random_ascii.call(1000)
      @persisted_class.attribute_two = random_ascii.call(1000)

      [@persisted_class, random_ascii.call(20)]
    end

    # persist each object
    start_time = Time.now
    objects.each do |object|
      # save it
      @ropl.put *object
    end
    puts "\nOne thousand ops time elapsed: #{Time.now - start_time} seconds.\n"
  end
end
