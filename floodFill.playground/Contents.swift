//An image is represented by an m x n integer grid image where image[i][j] represents the pixel value of the image.
//
//You are also given three integers sr, sc, and color. You should perform a flood fill on the image starting from the pixel image[sr][sc].
//
//To perform a flood fill, consider the starting pixel, plus any pixels connected 4-directionally to the starting pixel of the same color as the starting pixel, plus any pixels connected 4-directionally to those pixels (also with the same color), and so on. Replace the color of all of the aforementioned pixels with color.
//
//Return the modified image after performing the flood fill.

class Solution {
    
    // breadth first search
    static func floodFill(_ image: [[Int]], _ sr: Int, _ sc: Int, _ color: Int) -> [[Int]] {
        let oldColor = image[sr][sc]
        var newImage = image
        var visited = [(xCoord: Int, yCoord: Int)]()
        var toVisit = [(xCoord: Int, yCoord: Int)]()
        toVisit.append((xCoord: sr, yCoord: sc))
        
        repeat {
            guard let xCoord = toVisit.first?.xCoord,
                  let yCoord = toVisit.first?.yCoord else {
                return newImage
            }
            // 1. color the new image
            newImage[xCoord][yCoord] = color
            print("xCoord \(xCoord) and yCoord \(yCoord)")
            visited.append((xCoord: xCoord, yCoord: yCoord))
        
            // 2. add any adjoining cells to tovisit
            
            // one left
            let oneLeft = xCoord - 1
//            print("image count: \(image.count) oneLeft \(oneLeft) image[oneLeft].count \(image[oneLeft].count) yCoord \(yCoord)")
            if oneLeft >= 0 && image.count > oneLeft && image[oneLeft].count > yCoord && image[oneLeft][yCoord] == oldColor && !visited.contains(where: { pixel in
                pixel.yCoord == yCoord && pixel.xCoord == oneLeft
            })
            {
                toVisit.append((xCoord: oneLeft, yCoord: yCoord))
            }

            // one right
            let oneRight = xCoord + 1
            if image.count > oneRight && image[oneRight].count > yCoord && image[oneRight][yCoord] == oldColor && !visited.contains(where: { pixel in
                pixel.yCoord == yCoord && pixel.xCoord == oneRight
            }) {
                toVisit.append((xCoord: oneRight, yCoord: yCoord))
            }

            // one above
            let oneAbove = yCoord - 1
            if oneAbove >= 0 && image[xCoord].count > oneAbove && image[xCoord][oneAbove] == oldColor && !visited.contains(where: { pixel in
                pixel.yCoord == oneAbove && pixel.xCoord == xCoord
            }) {
                toVisit.append((xCoord: xCoord, yCoord: oneAbove))
            }

            // one above
            let oneBelow = yCoord + 1
            if image[xCoord].count > oneBelow && image[xCoord][oneBelow] == oldColor && !visited.contains(where: { pixel in
                pixel.yCoord == oneBelow && pixel.xCoord == xCoord
            }) {
                toVisit.append((xCoord: xCoord, yCoord: oneBelow))
            }
            
            // 3. Iterate
            toVisit.removeFirst()

        } while !toVisit.isEmpty
        
        return newImage
    }
    
    static func floodFillV2(_ image: [[Int]], _ sr: Int, _ sc: Int, _ color: Int) -> [[Int]] {
        if image[sr][sc] == color {
            return image
        } else {
            var newImage = image
            depthFirstSearch(&newImage, sr, sc, newImage[sr][sc], color)
            return newImage
        }
    }
    
    private static func depthFirstSearch(_ image: inout [[Int]], _ sr: Int, _ sc: Int, _ oldColor: Int, _ newColor: Int) {
        guard image[sr][sc] == oldColor else { return }
        
        image [sr][sc] = newColor
        if sr >= 1 {
            depthFirstSearch(&image, sr - 1, sc, oldColor, newColor)
        }
        if sr < image.count - 1 {
            depthFirstSearch(&image, sr + 1, sc, oldColor, newColor)
        }
        if sc >= 1 {
            depthFirstSearch(&image, sr, sc - 1, oldColor, newColor)
        }
        if sc < image[sr].count - 1 {
            depthFirstSearch(&image, sr, sc + 1, oldColor, newColor)
        }
    }
}

let image = [[1,1,1],[1,1,0],[1,0,1]]
print(Solution.floodFillV2(image, 1, 1, 2))
