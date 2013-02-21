# Ropl

There are plenty of ORMs out there.  With a K/V database like Riak,
having an ORM means an awkward fit, since Riak doesn't natively 
have any way to represent a Relationship.

In a conversation with Nathan Aschbacher, it was pointed out that 
all we really want in many cases is persistence.  So here it is -- 
a stupidly simple Riak Object Persistence Layer. ROPL.

## Installation

Add this line to your application's Gemfile:

    gem 'ropl'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ropl

## Usage

Take a look at test/test_composition_story.rb and test/test_oop_story.rb
The later is the preferred usage.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
