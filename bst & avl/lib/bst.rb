require 'byebug'

class BSTNode
  attr_accessor :left, :right
  attr_reader :value

  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end
end

class BinarySearchTree
  def initialize
    @root = nil
  end

  def insert(value)
    return @root = BSTNode.new(value) if @root.nil?
    self.class.insert!(@root, value)
  end

  def find(value)
    self.class.find!(@root, value)
  end

  def inorder
    self.class.inorder!(@root)
  end

  def postorder
    self.class.postorder!(@root)
  end

  def preorder
    self.class.preorder!(@root)
  end

  def height
    self.class.height!(@root)
  end

  def min
    self.class.min(@root)
  end

  def max
    self.class.max(@root)
  end

  def delete(value)
    self.class.delete!(@root, value)
  end

  def self.insert!(node, value)
    return BSTNode.new(value) if node.nil?
    current_node = node
    if value <= node.value
      if node.left.nil?
        node.left = BSTNode.new(value)
        return current_node
      else
        self.insert!(node.left, value)
      end
    else
      if node.right.nil?
        node.right = BSTNode.new(value)
        return current_node
      else
        self.insert!(node.right, value)
      end
    end
  end

  def self.find!(node, value)
    return nil if node.nil?
    return node if node.value == value
    if value <= node.value
      self.find!(node.left, value)
    else
      self.find!(node.right, value)
    end
  end

  def self.preorder!(node)
    return [] if node.nil?

    result = [node.value]
    result += self.preorder!(node.left) if node.left
    result += self.preorder!(node.right) if node.right
    result
  end

  def self.inorder!(node)
    return [] if node.nil?
    result = []
    result += self.inorder!(node.left) if node.left
    result << node.value
    result += self.inorder!(node.right) if node.right
    result
  end

  def self.postorder!(node)
    return [] if node.nil?
    result = []
    result += self.postorder!(node.left) if node.left
    result += self.postorder!(node.right) if node.right
    result << node.value
    result
  end

  def self.height!(node)
    return -1 if node.nil?
    return 0 if node.right.nil? && node.left.nil?
    left = 1 + self.height!(node.left)
    right = 1 + self.height!(node.right)
    return left > right ? left : right
  end

  def self.max(node)
    return nil if node.nil?
    return node if node.right.nil?
    self.max(node.right)
  end

  def self.min(node)
    return nil if node.nil?
    return node if node.left.nil?
    self.min(node.left)
  end

  def self.delete_min!(node)
    return nil if node.nil?
    if node.left.nil? && node.right.nil?
      node = nil
    elsif node.left.left.nil?  && !node.left.right.nil?
      node.left = node.left.right
    elsif node.left.left.nil?
      node.left = nil
    else
      self.delete_min!(node.left)
    end
  end

  def self.delete!(node, value)
    return nil if node.nil?
    if value < node.value
      node.left = self.delete!(node.left, value)
    elsif value > node.value
      node.right = self.delete!(node.right, value)
    else
      return node.left if node.right.nil?
      return node.right if node.left.nil?
      switch_node = node
      node.right = self.delete_min!(switch_node.right)
      node.left = switch_node.left
    end
    node
  end
end
