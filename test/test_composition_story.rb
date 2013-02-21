require File.expand_path(File.join('..','helper'), __FILE__)

class Animal
  include Ropl::Composition

  attr_accessor :type, :friends, :interests
end

class TestCompositionStory < Test::Unit::TestCase
  def test_story
    # set up Riak connection
    riak_config = YAML.load(File.read(File.expand_path(File.join('..','riak.yml'), __FILE__)))[:test]
    riak_client = Riak::Client.new riak_config

    henry = Animal.new
    henry.key       = 'henry'
    henry.type      = :chicken
    henry.friends   = 12
    henry.interests = ["walking in the woods", "eating berries"]

    timothy = Animal.new
    timothy.key       = 'timothy'
    timothy.type      = :bovine
    timothy.friends   = 17
    timothy.interests = ["walking in fields of grass", "eating berries", "hanging out with the family"]

    # ... later on that evening,
    # we decide that henry and timothy
    # are worth keeping around

    Animal.ropl riak_client

    henry.persist
    timothy.persist

    # ... and then some time later,
    # perhaps in a different context,
    # we want to compare interests

    henry   = Animal.retrieve 'henry'
    timothy = Animal.retrieve 'timothy'

    assert_equal ["eating berries"], henry.interests & timothy.interests
  end
end
