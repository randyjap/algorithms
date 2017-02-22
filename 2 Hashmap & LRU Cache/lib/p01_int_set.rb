class MaxIntSet
  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    validate!(num)
    @store[num] = true
  end

  def remove(num)
    validate!(num)
    @store[num] = false
  end

  def include?(num)
    self.validate!(num)
    @store[num]
  end

  private

  def is_valid?(num)
    raise "Out of bounds" unless num.between?(0, @store.length)
  end

  def validate!(num)
    is_valid?(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
  end

  def insert(num)
  end

  def remove(num)
  end

  def include?(num)
  end

  private

  def [](num)
  end

  def num_buckets
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
  end

  def insert(num)
  end

  def remove(num)
  end

  def include?(num)
  end

  private

  def [](num)
  end

  def num_buckets
  end

  def resize!
  end
end
