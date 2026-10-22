import Foundation

/*
 Given an array of intervals where intervals[i] = [starti, endi], merge all overlapping intervals, and return an array of the non-overlapping intervals that cover all the intervals in the input.

 Example 1:

 Input: intervals = [[1,3],[2,6],[8,10],[15,18]]
 Output: [[1,6],[8,10],[15,18]]
 Explanation: Since intervals [1,3] and [2,6] overlap, merge them into [1,6].

 Example 2:

 Input: intervals = [[1,4],[4,5]]
 Output: [[1,5]]
 Explanation: Intervals [1,4] and [4,5] are considered overlapping.

 Example 3:

 Input: intervals = [[4,7],[1,4]]
 Output: [[1,7]]
 Explanation: Intervals [1,4] and [4,7] are considered overlapping.

 Constraints:

     1 <= intervals.length <= 104
     intervals[i].length == 2
     0 <= starti <= endi <= 104

 */

class Solution {
    func merge(_ intervals: [[Int]]) -> [[Int]] {
        var result = [[Int]]()
        let sorted = insertionSortIntervals(intervals)
        var currentStart = 0
        var currentEnd = currentStart
//        print("sorted \(sorted)")
        
        while currentStart < sorted.count && currentEnd < sorted.count {
            var nextPosition = currentStart + 1
            var maxEnd = sorted[currentEnd][1]
            
            while nextPosition < sorted.count {
                if maxEnd >= sorted[nextPosition][0] {
                    currentEnd += 1
                    nextPosition += 1
                    maxEnd = max(maxEnd, max(sorted[currentEnd][1], sorted[currentStart][1]))
//                    print(maxEnd)
                } else {
                    break
                }
            }
//            print("result \(result)")
            result.append([sorted[currentStart][0], maxEnd])
            currentStart = currentEnd + 1
            currentEnd = currentStart
        }
        
        
        return result
    }
    
    internal func insertionSortIntervals(_ intervals: [[Int]]) -> [[Int]] {
        var sorted = intervals
        var iterator = 1
        while iterator < sorted.count {
            var nextPosition = iterator
            while nextPosition > 0 && sorted[nextPosition - 1][1] > sorted[nextPosition][1] {
                //swap
                let temp = sorted[nextPosition - 1]
                sorted[nextPosition - 1] = sorted[nextPosition]
                sorted[nextPosition] = temp
                nextPosition -= 1
            }
            iterator += 1
        }
        
        
        return sorted
    }
    
    internal func bubbleSortIntervals(_ intervals: [[Int]]) -> [[Int]]  {
        var sorted = intervals
        var moves = intervals.count
        
        while moves > 0 {
            var toMove = 0
            while toMove < sorted.count - 1 {
                if sorted[toMove][0] > sorted[toMove + 1][0] {
                    let temp = sorted[toMove + 1]
                    sorted[toMove + 1] = sorted[toMove]
                    sorted[toMove] = temp
                }
                toMove += 1
            }
            
            moves -= 1
        }
        return sorted
    }
}

print(Solution().insertionSortIntervals([[5,5], [4,4], [2,2], [3,3], [7,7]]))
print(Solution().bubbleSortIntervals([[5,5], [4,4], [2,2], [3,3], [7,7]]))
//print(Solution().merge([[1,4],[2,3]]))
//print(Solution().merge([[1,3],[2,6],[8,10],[15,18]]))
//print(Solution().merge([[2,3],[4,5],[6,7],[8,9],[1,10]]))
