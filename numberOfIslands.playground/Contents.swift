//Given an m x n 2D binary grid grid which represents a map of '1's (land) and '0's (water), return the number of islands.
//
//An island is surrounded by water and is formed by connecting adjacent lands horizontally or vertically. You may assume all four edges of the grid are all surrounded by water.

class Solution {
    static func numIslands(_ grid: [[Character]]) -> Int {
        var visited = Array(repeating: Array(repeating: false, count: grid.first?.count ?? 0), count: grid.count)
        var islandCount = 0
        let land: Character = "1"
        
        for (x, itemX) in grid.enumerated() {
            for (y, itemY) in itemX.enumerated() {
                if !visited[x][y] {
                    if itemY == land {
//                        print("island found: \(x), \(y)")
                        islandCount = islandCount + 1
                        visitEntireIslandDFS(grid, x, y, &visited)
                    } else {
                        visited[x][y] = true
                    }
                }
            }
        }
        return islandCount
    }
    
    private static func visitEntireIslandDFS(_ grid: [[Character]], _ startX: Int, _ startY: Int, _ visited: inout [[Bool]]) {
        let land: Character = "1"
        guard startX >= 0, startX < grid.count, startY >= 0, startY < grid[startX].count, !visited[startX][startY] else { return }
        
        visited[startX][startY] = true
                
        guard grid[startX][startY] == land else { return }
        
        visitEntireIslandDFS(grid, startX + 1, startY, &visited)
        visitEntireIslandDFS(grid, startX - 1, startY, &visited)
        visitEntireIslandDFS(grid, startX, startY + 1, &visited)
        visitEntireIslandDFS(grid, startX, startY - 1, &visited)
    }
}

let grid1: [[Character]] = [
  ["1","1","1","1","0"],
  ["1","1","0","1","0"],
  ["1","1","0","0","0"],
  ["0","0","0","0","0"]
] // 1

let grid2: [[Character]]  = [
    ["1","1","0","0","0"],
    ["1","1","0","0","0"],
    ["0","0","1","0","0"],
    ["0","0","0","1","1"]
] // 3


print(Solution.numIslands(grid2))
