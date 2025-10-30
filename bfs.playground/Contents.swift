import Foundation

func shortestPathBFS(graph: [String: [String]], start: String, end: String) -> [String]? {
    var queue: [(node: String, path: [String])] = [(start, [start])]
    var visited: Set<String> = [start]
    
    while !queue.isEmpty {
        let (node, path) = queue.removeFirst()
        
        if node == end {
            return path
        }
        
        for neighbor in graph[node] ?? [] {
            if !visited.contains(neighbor) {
                visited.insert(neighbor)
                queue.append((neighbor, path + [neighbor]))
            }
        }
    }
    
    return nil // No path found
}

// Example Usage
let graph = [
    "A": ["B", "C"],
    "B": ["A", "D", "E"],
    "C": ["A", "F"],
    "D": ["B"],
    "E": ["B", "F"],
    "F": ["C", "E"]
]

if let path = shortestPathBFS(graph: graph, start: "A", end: "F") {
    print("Shortest path: \(path)")
} else {
    print("No path found")
}
