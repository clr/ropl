require File.expand_path(File.join('..','helper'), __FILE__)

class Animal
  attr_accessor :type, :friends, :interests
end

class TestOopStory < Test::Unit::TestCase
  def test_story
    # set up Riak connection and persistence object
    riak_config = YAML.load(File.read(File.expand_path(File.join('..','riak.yml'), __FILE__)))[:test]
    riak_client = Riak::Client.new riak_config
    ropl        = Ropl::Ropl.new riak_client

    # go about your day
    henry = Animal.new
    henry.type      = :chicken
    henry.friends   = 12
    henry.interests = ["walking in the woods", "eating berries"]

    timothy = Animal.new
    timothy.type      = :bovine
    timothy.friends   = 17
    timothy.interests = ["walking in fields of grass", "eating berries", "hanging out with the family"]

    # later on that evening,
    # we decide that henry and timothy
    # are worth keeping around

    ropl.put henry,   :henry
    ropl.put timothy, :timothy

    # then some time even later,
    # perhaps in a different context,
    # we want to compare interests

    henry   = ropl.get Animal, :henry
    timothy = ropl.get Animal, :timothy

    assert_equal ["eating berries"], henry.interests & timothy.interests
  end
end
