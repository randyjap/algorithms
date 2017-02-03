require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @store = StaticArray.new(8)
    @capacity = 8
    @length = 0
    @start_idx = 0
  end

  # O(1)
  def [](index)
    check_index(index)
    @store[(@start_idx + index) % @capacity]
  end

  # O(1)
  def []=(index, val)
    @store[(@start_idx + index) % @capacity] = val
  end

  # O(1)
  def pop
    raise "index out of bounds" if @length <= 0
    last_item = @store[(@start_idx + @length - 1) % @capacity]
    @length -= 1
    last_item
  end

  # O(1) ammortized
  def push(val)
    resize! if @length >= @capacity
    @store[(@start_idx + @length) % @capacity] = val
    @length += 1
  end

  # O(1)
  def shift
    raise "index out of bounds" if @length <= 0
    @length -= 1
    first_item = @store[@start_idx]
    @start_idx = (@start_idx + 1) % @capacity
    first_item
  end

  # O(1) ammortized
  def unshift(val)
    resize! if @length >= @capacity
    @start_idx = (@start_idx - 1) % @capacity
    @store[@start_idx] = val
    @length += 1
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
    raise "index out of bounds" if @length - 1 < index || index < - @length
  end

  def resize!
    new_size_store = Array.new(@capacity * 2)
    @length.times do |idx|
      new_size_store[idx] = self[idx]
    end
    @store = new_size_store
    @capacity = @capacity * 2
    @start_idx = 0
  end
end
