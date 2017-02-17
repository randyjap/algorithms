require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      node = @map[key]
      update_link!(node)
      node.val
    else
      calc!(key)
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    val = @prc.call(key)
    eject! if count == @max
    @store.insert(key, val)
    @map[key] = @store.last
    val
  end

  def update_link!(link)
    @store.remove(link.key)
    key, val = link.key, link.val
    @store.insert(key, val)
    @map[key] = @store.last
  end

  def eject!
    key = @store.first.key
    @store.remove(@store.first.key)
    @map.delete(key)
  end
end
