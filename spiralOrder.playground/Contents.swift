//Given an m x n matrix, return all elements of the matrix in spiral order.

enum Direction {
    case left
    case right
    case up
    case down
}

func spiralOrder(_ matrix: [[Int]]) -> [Int] {
    var visited = [Int: [Int: Bool]]()
    
    return dfs(matrix, (m: 0, n: 0, direction: .right), &visited)
}

func dfs(_ matrix: [[Int]], _ location: (m: Int, n: Int, direction: Direction), _ visited: inout [Int: [Int: Bool]]) -> [Int] {
    print("m: \(location.m), n: \(location.n)")
    if visited[location.m] != nil {
        visited[location.m]![location.n] = true
    } else {
        visited[location.m] = [location.n: true]
    }
    
    var nextDfs: [Int]?
    
    switch location.direction {
    case .right:
        if matrix[location.m].count > (location.n + 1) && visited[location.m]?[location.n + 1] != true {
            nextDfs = dfs(matrix, (m: location.m, n: location.n + 1, direction: .right), &visited)
        }
    case .left:
        if location.n - 1 >= 0 && visited[location.m]?[location.n - 1] != true {
            nextDfs = dfs(matrix, (m: location.m, n: location.n - 1, direction: .left), &visited)
        }
    case .up:
        if location.m - 1 >= 0 && visited[location.m - 1]?[location.n] != true {
            nextDfs = dfs(matrix, (m: location.m - 1, n: location.n, direction: .up), &visited)
        }
    case .down:
        if matrix.count > (location.m + 1) && visited[location.m + 1]?[location.n] != true {
            nextDfs = dfs(matrix, (m: location.m + 1, n: location.n, direction: .down), &visited)
        }
    }
    
    
    guard nextDfs == nil else {
        return [matrix[location.m][location.n]] + (nextDfs ?? [Int]())
    }

    // right
    if matrix[location.m].count > (location.n + 1) && visited[location.m]?[location.n + 1] != true {
        nextDfs = dfs(matrix, (m: location.m, n: location.n + 1, direction: .right), &visited)
        
        // down
    } else if matrix.count > (location.m + 1) && visited[location.m + 1]?[location.n] != true {
        nextDfs = dfs(matrix, (m: location.m + 1, n: location.n, direction: .down), &visited)
        
        // left
    } else if location.n - 1 >= 0 && visited[location.m]?[location.n - 1] != true {
        nextDfs = dfs(matrix, (m: location.m, n: location.n - 1, direction: .left), &visited)
        
        // up
    } else if location.m - 1 >= 0 && visited[location.m - 1]?[location.n] != true {
        nextDfs = dfs(matrix, (m: location.m - 1, n: location.n, direction: .up), &visited)
    }
    
    return [matrix[location.m][location.n]] + (nextDfs ?? [Int]())
}



//let matrix = [[1,2,3],[4,5,6],[7,8,9]] //[1,2,3,6,9,8,7,4,5]
//print(spiralOrder(matrix))


let matrix2 = [
    [1,2,3,4],
    [5,6,7,8],
    [9,10,11,12],
    [13,14,15,16]
]
print(spiralOrder(matrix2)) // [1,2,3,4,8,12,16,15,14,13,9,5,6,7,11,10]
