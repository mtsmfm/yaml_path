require 'test_helper'

class YamlPathTest < Test::Unit::TestCase
  def test_apple
    yaml = <<~YAML
      a:
        b: c
        c: d
    YAML

    new_yaml = YamlPath.replace(yaml, '$.a.b') do |content|
      content * 3
    end

    assert_equal <<~YAML, new_yaml
      a:
        b: ccc
        c: d
    YAML
  end
end
