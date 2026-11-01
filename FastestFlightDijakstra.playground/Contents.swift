import Foundation

class Edge {
    let weight: Int
    let destination: String
    
    public init(destination: String, weight: Int) {
        self.weight = weight
        self.destination = destination
    }
}


func dijkstra(start: String, routes: [String: [Edge]]) -> [String: Int] {
    var visited: Set<String> = []
    var distances: [String: Int] = [start: 0]
    
    var queue: [(node: String, distance: Int)] = [(start, 0)]
    
    while !queue.isEmpty {
        queue.sort { $0.distance > $1.distance }

        
        if let current = queue.popLast(),
            !visited.contains(current.node),
            let currentDistance = distances[current.node],
           currentDistance <= current.distance {
            visited.insert(current.node)
            
            if let currentRoutes = routes[current.node] {
                for edge in currentRoutes {
                    let neighbor = edge.destination
                    let newDistance = current.distance + edge.weight
                    
                    if newDistance <= (distances[neighbor] ?? Int.max){
                        distances[neighbor] = newDistance
                        queue.append((node: neighbor, distance: newDistance) )
                    }
                }
            }
        }
    }
    
    return distances
}

let graph: [String: [Edge]] = [
    "A": [Edge(destination: "B", weight: 4), Edge(destination: "C", weight: 2)],
    "B": [Edge(destination: "C", weight: 1), Edge(destination: "D", weight: 5)],
    "C": [Edge(destination: "D", weight: 8), Edge(destination: "E", weight: 10)],
    "D": [Edge(destination: "E", weight: 2)],
    "E": []
]

let shortestDistances = dijkstra(start: "A", routes: graph)
print(shortestDistances)
