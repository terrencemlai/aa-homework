
class GraphNode
    attr_accessor :value, :neighbors

    def initialize(value)
        @value = value
        @neighbors = []
    end

end

def bfs(starting_node, target_value)
    return starting_node if starting_node.value == target_value
    checked_nodes = []
    queue = starting_node.neighbors
    until queue.empty?
        next_node = queue.shift
        if checked_nodes.include?(next_node)
            next
        else 
            checked_nodes << next_node
            return next_node if next_node.value == target_value
            queue += next_node.neighbors 
        end
    end
    nil
end

a = GraphNode.new('a')
b = GraphNode.new('b')
c = GraphNode.new('c')
d = GraphNode.new('d')
e = GraphNode.new('e')
f = GraphNode.new('f')
a.neighbors = [b, c, e]
c.neighbors = [b, d]
e.neighbors = [a]
f.neighbors = [e]

p bfs(a, "b")
p bfs(a, "f")