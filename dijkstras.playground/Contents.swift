class Node {

    let identifier: Int
    var distance = Int.max
    var edges = [Edge]()
    var visited = false

    init(identifier: Int) {
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
    let from: Node
    let to: Node
    let weight: Int

    init(to: Node, from: Node, weight: Int) {
        self.to = to
        self.from = from
        self.weight = weight
    }
}


