require_relative 'graph'
require 'set'
require 'byebug'
# Implementing topological sort using both Khan's and Tarian's algorithms

def topological_sort(vertices)
  in_edge_count = {}
  list = []
  queue = []
  vertices.each do |vertex|
    in_edge_count[vertex] = vertex.in_edges.count
    queue << vertex if vertex.in_edges.empty?
  end
  until queue.empty?
    u = queue.shift
    list << u
    u.out_edges.each do |vertex|
      to_vertex = vertex.to_vertex
      in_edge_count[to_vertex] -= 1
      queue << to_vertex if in_edge_count[to_vertex] == 0
    end
  end
  list
end

def topological_sort(vertices)
  list = []
  current_set = Set.new

  vertices.each do |vertex|
    search(vertex, current_set, list) unless current_set.include?(vertex)
  end

  list
end

def search(vertex, current_set, list)
  current_set.add(vertex)

  vertex.out_edges.each do |edge|
    new_vertex = edge.to_vertex
    search(new_vertex, current_set, list) unless list.include?(new_vertex)
  end

  list.unshift(vertex)
end
