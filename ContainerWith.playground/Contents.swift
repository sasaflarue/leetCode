
/*
 11. Container With Most Water
 Solved
 Medium
 Topics
 premium lock iconCompanies
 Hint

 You are given an integer array height of length n. There are n vertical lines drawn such that the two endpoints of the ith line are (i, 0) and (i, height[i]).

 Find two lines that together with the x-axis form a container, such that the container contains the most water.

 Return the maximum amount of water a container can store.

 Notice that you may not slant the container.
 
 Input: height = [1,8,6,2,5,4,8,3,7]
 Output: 49
 Explanation: The above vertical lines are represented by array [1,8,6,2,5,4,8,3,7]. In this case, the max area of water (blue section) the container can contain is 49.

 Example 2:

 Input: height = [1,1]
 Output: 1

 */

func maxArea(_ height: [Int]) -> Int {
    var largestArea = 0
    var firstIterator = 0
    var lastIterator = height.count - 1
    
    while firstIterator < lastIterator {
        let first = height[firstIterator]
        let last = height[lastIterator]
        let smallest = min(first, last)
        let distance = lastIterator - firstIterator
//        print("first \(first), last \(last), distance \(distance)")
        largestArea = max(largestArea, smallest * distance)
        
        if first < last {
            firstIterator += 1
        } else {
            lastIterator -= 1
        }
//        print(largestArea)
    }
    return largestArea
}

print(maxArea([1,8,6,2,5,4,8,3,7]) == 49)
print(maxArea([1,1]) == 1)
