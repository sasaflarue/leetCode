class Node {

    let identifier: String
//    var distance = Int.max
    var edges = [Edge]()
    var visited = false

    init(_ identifier: String) {
        self.identifier = identifier
    }
}

extension Node: Hashable {
    static func == (lhs: Node, rhs: Node) -> Bool {
        return lhs === rhs
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self).hashValue)
    }
}

class Edge {
    let to: Node
    let weight: Int

    init(to: Node, weight: Int) {
        self.to = to
        self.weight = weight
    }
}


func dijkstra(graph: [String: [Edge]], start: String, end: String) -> [String]? {
    var distances: [String: Int] = [:]
    var previousNodes: [String: String] = [:]
    var priorityQueue: [(node: String, cost: Int)] = [(start, 0)]
    
    for node in graph.keys {
        distances[node] = node == start ? 0 : Int.max
    }
    
    while !priorityQueue.isEmpty {
        priorityQueue.sort { $0.cost < $1.cost } // Sort by lowest cost
        let (currentNode, currentCost) = priorityQueue.removeFirst()
        
        if currentNode == end {
            var path: [String] = []
            var step: String? = end
            while let node = step {
                path.insert(node, at: 0)
                step = previousNodes[node]
            }
            return path
        }
        
        for edge in graph[currentNode] ?? [] {
            let newCost = currentCost + edge.weight
            if newCost < distances[edge.to.identifier] ?? Int.max {
                distances[edge.to.identifier] = newCost
                previousNodes[edge.to.identifier] = currentNode
                priorityQueue.append((edge.to.identifier, newCost))
            }
        }
    }
    
    return nil // No path found
}

// Example Usage
let weightedGraph: [String: [Edge]] = [
    "A": [Edge(to: Node("B"), weight: 4), Edge(to: Node("C"), weight: 2)],
    "B": [Edge(to: Node("C"), weight: 5), Edge(to: Node("D"), weight: 10)],
    "C": [Edge(to: Node("D"), weight: 3)],
    "D": []
]

if let path = dijkstra(graph: weightedGraph, start: "A", end: "D") {
    print("Shortest path: \(path)")
} else {
    print("No path found")
}


func dijkstraShortPathNumber(graph: [String: [Edge]], start: String, end: String) -> [String]? {
    var distances = [String: Int]()
    var queue: [(node: String, cost: Int)] = [(start, 0)]
    
    while !queue.isEmpty {
        queue.sort { $0.cost < $1.cost }
        let currentNode = queue.removeFirst()
        
        if currentNode.node == end {
            //found shortest path
            return nil
        } else {
            for edge in graph[currentNode.node] ?? [] {
                let newCost = currentNode.cost + edge.weight
                if newCost <= distances[edge.to.identifier] ?? Int.max {
                    distances[edge.to.identifier] = edge.weight
                    queue.append((edge.to.identifier, newCost))
                }
            }
        }
    }
    
    return nil
}


if let path = dijkstraShortPathNumber(graph: weightedGraph, start: "A", end: "D") {
    print("Shortest path: \(path)") // should be 5
} else {
    print("No path found")
}
