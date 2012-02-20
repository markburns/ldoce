# Ldoce
Easily interface with the Longman Dictionary of Contemporary English API from Ruby:

## Installation

Add this line to your application's Gemfile:

    gem 'ldoce'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ldoce

## Usage

```ruby
cat = Word.search 'cat'
cat.play #plays mp3 sample - only working for Mac at the moment
cat.definition
#=> "A small four legged animal commonly kept as a pet"
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
