include Comparable

class Element
  attr_reader :value
  attr_accessor :left, :right

  def initialize(v)
    @value = v
    @left = EmptyNode.new
    @right = EmptyNode.new
  end

  def push(v)
    case value <=> v
    when 1 then push_left(v)
    when -1 then push_right(v)
    when 0 then false # the value is already present
    end
  end
  alias_method :<<, :push

  def include?(v)
    case value <=> v
    when 1 then left.include?(v)
    when -1 then right.include?(v)
    when 0 then true # the current node is equal to the value
    end
  end
