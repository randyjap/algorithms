require 'byebug'

class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    sum = 0
    self.each_with_index do |el, idx|
      sum ^= (el * idx).hash
    end
    sum
  end
end

class String
  def hash
    self.chars.each_with_index.inject(0) { |acc, (chr, idx)| acc ^= (chr.ord * idx).hash }
  end
end

class Hash
  def hash
    sum = 0
    self.each { |key, value| sum ^= key.hash * value.hash }
    sum
  end
end
