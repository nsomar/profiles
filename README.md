# Profiles

Profiles is a command line tool that helps you inspect your local list of provision profiles for a give UDID, and it also can search an ipa’s embedded provision profile for it.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'profiles'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install profiles

## Usage

Search the local list of provision profiles managed by Xcode

    prov local -u <UDID>

Checks if an ipa contains a UDID    

    prov ipa -p <IPA_PATH> -u <UDID>

## Contributing

1. Fork it ( https://github.com/[my-github-username]/profiles/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
