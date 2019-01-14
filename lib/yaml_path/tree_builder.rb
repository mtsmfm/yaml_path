require 'yaml'

module YamlPath
  class PathStack
    def initialize
      @stack = ['$']
    end

    def push(node)
      @stack.push(node)
    end

    def pop
      @stack.pop
    end

    def match?(yaml_path_str)
      yaml_path_str == @stack.join('.')
    end
  end

  class TreeBuilder < YAML::TreeBuilder
    def initialize(yaml_path:, replace_proc:)
      super()

      @yaml_path = yaml_path
      @replace_proc = replace_proc
      @path_stack = PathStack.new
    end

    def scalar(value, anchor, tag, plain, quoted, style)
      if @path_stack.match?(@yaml_path)
        value = @replace_proc.call(value)
      end

      super(value, anchor, tag, plain, quoted, style).tap do
        if YAML::Nodes::Mapping === @last
          if @last.children.size.odd?
            @path_stack.push(@last.children.last.value)
          else
            @path_stack.pop
          end
        end
      end
    end

    def alias(*)
      super.tap do
        if YAML::Nodes::Mapping === @last
          if @last.children.size.odd?
            # noop
          else
            @path_stack.pop
          end
        end
      end
    end

    %w(end_mapping end_sequence).each do |m|
      define_method(m) do |*args|
        brothers = @stack[-2].children
        if Psych::Nodes::Scalar === brothers[brothers.index(@last) - 1]
          @path_stack.pop
        end
        super(*args)
      end
    end
  end
end
