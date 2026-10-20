import Foundation

/*
 Given an array of positive integers nums and a positive integer target, return the minimal length of a subarray whose sum is greater than or equal to target. If there is no such subarray, return 0 instead.

 Example 1:

 Input: target = 7, nums = [2,3,1,2,4,3]
 Output: 2
 Explanation: The subarray [4,3] has the minimal length under the problem constraint.

 Example 2:

 Input: target = 4, nums = [1,4,4]
 Output: 1

 Example 3:

 Input: target = 11, nums = [1,1,1,1,1,1,1,1]
 Output: 0

 Constraints:
     1 <= target <= 109
     1 <= nums.length <= 105
     1 <= nums[i] <= 104

 */

class Solution {
    func minSubArrayLen(_ target: Int, _ nums: [Int]) -> Int {
        var minArraySize = Int.max
//        for (index, item) in nums.enumerated() {
//            var sum = item
//            var next = index + 1
//            var arraySize = 1
//            if sum >= target && arraySize == 1 { return 1 }
//            while next < nums.count {
//                if sum < target {
//                    sum = sum + nums[next]
//                    arraySize = arraySize + 1
//                }
//                if sum >= target && arraySize < minArraySize {
//                    
//                    minArraySize = arraySize
//                    break
//                }
//                next = next + 1
//            }
//        }
//

        
//        for (index, item) in nums.enumerated() {
        var firstIterator = 0
        var secondIterator = firstIterator + 1
        var currentSize = 1
        var currentSum = 0
        
        for secondIterator in 0..<nums.count {
            currentSum += nums[secondIterator]
            
            while currentSum >= target && firstIterator <= secondIterator {
                minArraySize = min(minArraySize, secondIterator - firstIterator + 1)
                currentSum -= nums[firstIterator]
                firstIterator += 1
            }
        }
        
        
        
        
        if minArraySize == Int.max { minArraySize = 0 }
        return minArraySize
    }
}

print(Solution().minSubArrayLen(7, [2,3,1,2,4,3])) //2
print(Solution().minSubArrayLen(4, [1,4,4])) // 1
print(Solution().minSubArrayLen(11, [1,1,1,1,1,1,1,1])) // 0
print(Solution().minSubArrayLen(11, [1,2,3,4,5])) // 3
print(Solution().minSubArrayLen(6, [10])) // 1
print(Solution().minSubArrayLen(7, [1,1,1,1,7])) // 1
