//You have a 2-D grid of size m x n representing a box, and you have n balls. The box is open on the top and bottom sides.
//
//Each cell in the box has a diagonal board spanning two corners of the cell that can redirect a ball to the right or to the left.
//
//    A board that redirects the ball to the right spans the top-left corner to the bottom-right corner and is represented in the grid as 1.
//    A board that redirects the ball to the left spans the top-right corner to the bottom-left corner and is represented in the grid as -1.
//
//We drop one ball at the top of each column of the box. Each ball can get stuck in the box or fall out of the bottom. A ball gets stuck if it hits a "V" shaped pattern between two boards or if a board redirects the ball into either wall of the box.
//
//Return an array answer of size n where answer[i] is the column that the ball falls out of at the bottom after dropping the ball from the ith column at the top, or -1 if the ball gets stuck in the box.


func findBall(_ grid: [[Int]]) -> [Int] {
    var startX = 0
    var exitCol = [Int]()
    while startX < grid.first?.count ?? 0 {
        exitCol.append(findPath(grid, (y: grid.count - 1, x: startX)))
        startX = startX + 1
    }
    
    return exitCol
}

func findPath(_ grid: [[Int]], _ location: (y: Int, x: Int)) -> Int {
    guard location.y < grid.count else {
        return location.x
    }
    var curY = location.y
    //down right
    if grid[location.y][location.x] == 1 && grid[location.y].count > location.x + 1 && grid[location.y][location.x + 1] == {
        
    }
    //down left
    if grid[location.y][location.x] == -1 {
        
    }
    
    
    return -1
}

let grid1 = [[-1]]
print(findBall(grid1))
