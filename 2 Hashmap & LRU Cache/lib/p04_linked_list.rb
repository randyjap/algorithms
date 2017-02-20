class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove_self
    @prev.next = @next
    @next.prev = @prev
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Link.new(:head)
    @tail = Link.new(:tail)
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    return nil if @head.next == @tail
    @head.next
  end

  def last
    return nil if @head.next == @tail
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    return nil if self.empty?
    temp = @head.next
    until temp.next.nil?
      return temp.val if temp.key == key
      temp = temp.next
    end
    nil
  end

  def include?(key)
    return false if empty?
    temp = @head.next
    until temp.next.nil?
      return true if temp.key == key
      temp = temp.next
    end
    false
  end

  def insert(key, val)
    if self.include?(key)
      temp = @head.next
      until temp.next.nil?
        if temp.key == key
          temp.val = val
        end
        temp = temp.next
      end
    else
      new_node = Link.new(key, val)
      new_node.next = @tail
      new_node.prev = @tail.prev
      @tail.prev.next = new_node
      @tail.prev = new_node
    end
  end

  def remove(key)
    return if self.empty?
    temp = @head.next
    return temp.remove_self if temp.key == key until temp.next.nil?
  end

  def each
    return [] if self.empty?
    temp = @head.next
    until temp.next.nil?
      yield temp
      temp = temp.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
