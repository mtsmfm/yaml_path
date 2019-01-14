require "yaml_path/version"
require "yaml"
require "yaml_path/tree_builder"

module YamlPath
  class Error < StandardError; end

  class << self
    def replace(yaml_content, yaml_path, &block)
      YAML::Parser.new(TreeBuilder.new(yaml_path: yaml_path, replace_proc: block)).parse(yaml_content).handler.root.to_yaml
    end
  end
end
