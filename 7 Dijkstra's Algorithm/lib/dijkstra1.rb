require_relative 'graph'

def dijkstra1(source)
  paths = {}
  potential_paths = { source => { cost: 0, last_edge: nil } }

  until potential_paths.empty?
    vertex, data = potential_paths.min_by { |vertex, data| data[:cost] }
    vertex
    paths[vertex] = potential_paths[vertex]
    potential_paths.delete(vertex)
    update_potential_paths(vertex, paths, potential_paths)
  end
  paths
end

def update_potential_paths(vertex, paths, potential_paths)
  path_vertex_cost = paths[vertex][:cost]

  vertex.out_edges.each do |edge|
    to_vertex = edge.to_vertex

    next if paths.has_key?(to_vertex)

    ext_path_cost = path_vertex_cost + edge.cost

    next if potential_paths.has_key?(to_vertex) && potential_paths[to_vertex][:cost] <= ext_path_cost

    potential_paths[to_vertex] = {
      cost: ext_path_cost, last_edge: edge
    }
  end
end
