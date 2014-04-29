# Hostel

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'hostel'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hostel

## Usage

If you want to overwrite the existing behavior, you can run
`rails g hostel:install` to create a sample.yml file and a configuration file.

In your environment files you could also specify a subdomain if you need to:
```
Cio::Application.configure do
  config.subdomain = 'test'
end
```


## Contributing

1. Fork it ( https://github.com/[my-github-username]/hostel/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
