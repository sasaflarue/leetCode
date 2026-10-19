import Foundation

/*
 You are given an integer array nums of length n and an integer target.

 Find three integers at distinct indices in nums such that the sum is closest to target.

 Return the sum of the three integers.

 You may assume that each input would have exactly one solution.

  

 Example 1:

 Input: nums = [-1,2,1,-4], target = 1
 Output: 2
 Explanation: The sum that is closest to the target is 2. (-1 + 2 + 1 = 2).

 Example 2:

 Input: nums = [0,0,0], target = 1
 Output: 0
 Explanation: The sum that is closest to the target is 0. (0 + 0 + 0 = 0).
 */

class Solution {
    func threeSumClosest(_ nums: [Int], _ target: Int) -> Int {
        let sortedNums = nums.sorted()
        var firstIterator = 0
        var secondIterator = 1
        var thirdIterator = 2
        var closest = sortedNums[firstIterator] + sortedNums[secondIterator] + sortedNums[thirdIterator]
        
        while firstIterator < nums.count - 2 {
//            if sortedNums[firstIterator] > target { return 0 }
            
            let current = sortedNums[firstIterator] + sortedNums[secondIterator] + sortedNums[thirdIterator]
//            print("current: \(current)")
            if  abs(current - target) < abs(closest - target) {
//                print(closest)
                closest = current
            }
            
            if thirdIterator < nums.count - 1 {
                thirdIterator = thirdIterator + 1
            } else if secondIterator < nums.count - 2 {
                secondIterator = secondIterator + 1
                thirdIterator = secondIterator + 1
            } else {
                firstIterator = firstIterator + 1
                secondIterator = firstIterator + 1
                thirdIterator = secondIterator + 1
            }
        }
        return closest
    }
}

print(Solution().threeSumClosest([-1,2,1,-4], 1))
print(Solution().threeSumClosest([0,0,0], 1))
print(Solution().threeSumClosest([1,1,1], 0))
print(Solution().threeSumClosest([1,1,1], -100))
