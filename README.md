# YamlPath

[WIP]

A tool to modify YAML contents by JSON path like operators.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'yaml_path'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install yaml_path

## Usage

```ruby
yaml = <<~YAML
a:
  b: c
  c: d
YAML

new_yaml = YamlPath.replace(yaml, '$.a.b') do |content|
  puts content # => c

  content * 3
end

puts new_yaml

# =>
# a:
#  b: ccc
#  c: d
```

## TODOs

- [] `YamlPath.add`
- [] `YamlPath.remove`
- [] `*` operator
- [] `..` operator
- [] Array index operator

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/yaml_path. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the YamlPath project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/yaml_path/blob/master/CODE_OF_CONDUCT.md).
