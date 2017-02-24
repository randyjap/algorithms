require 'byebug'
class BinaryMinHeap
  def initialize(&prc)
    @store = []
    @prc = prc
  end

  def count
    @store.count
  end

  def extract
    extracted_number = @store[0]
    @store[0], @store[-1] = @store[-1], @store[0]
    @store = BinaryMinHeap.heapify_down(@store[0..-2], 0)
    extracted_number
  end

  def peek

  end

  def push(val)
    @store << val
    @store[0], @store[-1] = @store[-1], @store[0]
    BinaryMinHeap.heapify_up(@store, count - 1)
  end

  protected
  attr_accessor :prc, :store

  public
  def self.child_indices(len, parent_index)
    children = []
    left = parent_index * 2 + 1
    right = parent_index * 2 + 2
    children << left if left < len
    children << right if right < len
    children
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index <= 0
    (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |first, second| first <=> second }
    until self.child_indices(len, parent_idx).empty?
      children = self.child_indices(len, parent_idx)
      child_idx = children.first
      if children.length == 2
        child_idx = prc.call(array[children.first], array[children.last]) == -1 ? children.first : children.last
      end
      return array if prc.call(array[parent_idx], array[child_idx]) <= 0
      array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
      parent_idx = child_idx
    end
    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new { |first, second| first <=> second }

    temp = child_idx
    until temp == 0 || prc.call(array[temp], array[self.parent_index(temp)]) >= 0
      parent_idx_swap = self.parent_index(temp)
      temp_child = array[temp]
      array[temp] = array[parent_idx_swap]
      array[parent_idx_swap] = temp_child
      temp = self.parent_index(temp)
    end
    array
  end
end

def self.heapify_down(array, parent_idx, len = array.length, &prc)
  prc ||= Proc.new { |first, second| first <=> second }
  until self.child_indices(len, parent_idx).empty?
    children = self.child_indices(len, parent_idx)
    child_idx = children.first
    if children.length == 2
      child_idx = prc.call(array[children.first], array[children.last]) == -1 ? children.first : children.last
    end
    return array if prc.call(array[parent_idx], array[child_idx]) <= 0
    array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
    parent_idx = child_idx
  end
  array
end

def self.heapify_up(array, child_idx, len = array.length, &prc)
  prc ||= Proc.new { |first, second| first <=> second }

  temp = child_idx
  until temp == 0 || prc.call(array[temp], array[self.parent_index(temp)]) >= 0
    parent_idx_swap = self.parent_index(temp)
    temp_child = array[temp]
    array[temp] = array[parent_idx_swap]
    array[parent_idx_swap] = temp_child
    temp = self.parent_index(temp)
  end
  array
end
