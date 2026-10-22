import Foundation

/*
 Given an integer array nums and an integer k, return true if nums has a good subarray or false otherwise.
 A good subarray is a subarray where:

     its length is at least two, and
     the sum of the elements of the subarray is a multiple of k.

 Note that:

     A subarray is a contiguous part of the array.
     An integer x is a multiple of k if there exists an integer n such that x = n * k. 0 is always a multiple of k.

 Example 1:

 Input: nums = [23,2,4,6,7], k = 6
 Output: true
 Explanation: [2, 4] is a continuous subarray of size 2 whose elements sum up to 6.

 Example 2:

 Input: nums = [23,2,6,4,7], k = 6
 Output: true
 Explanation: [23, 2, 6, 4, 7] is an continuous subarray of size 5 whose elements sum up to 42.
 42 is a multiple of 6 because 42 = 7 * 6 and 7 is an integer.

 Example 3:
 Input: nums = [23,2,6,4,7], k = 13
 Output: false
 */


class Solution {
//    func checkSubarraySum(_ nums: [Int], _ k: Int) -> Bool {
//        guard nums.count > 1 else { return false }
//        
//        var iterator1 = 0
//        var iterator2 = 1
//        var sums: [[Int?]] = Array(repeating: Array(repeating: nil, count: nums.count), count: nums.count)
//        sums[0][0] = nums[0]
//        
//        while iterator1 < nums.count - 1 {
//            iterator2 = iterator1 + 1
//            var curSum = 0
//            sums[iterator1][iterator1] = nums[iterator1]
//            while iterator2 < nums.count {
//                if let firstSum = sums[iterator1][iterator2 - 1] {
//                    sums[iterator1][iterator2] = firstSum + nums[iterator2]
////                                    print(sums)
//                    if let check = sums[iterator1][iterator2], check % k == 0 || check == 0 {
//                        return true
//                    }
//                }
//                iterator2 += 1
//            }
//            iterator1 += 1
////            print("looping iterator 1: \(iterator1)")
//        }
//        
//        
//        return false
//    }
    
    func checkSubarraySum(_ nums: [Int], _ k: Int) -> Bool {
        var iterator1 = 0
        var iterator2 = 1
        
        while iterator1 < nums.count - 1 {
            iterator2 = iterator1 + 1
            
            var curSum = nums[iterator1]
            while iterator2 < nums.count {
                curSum += nums[iterator2]
                if curSum % k == 0 || curSum == 0 {
                    return true
                }
                iterator2 += 1
            }
            iterator1 += 1
        }
        return false
    }
}

print(Solution().checkSubarraySum([23,2,4,6,7], 6)) //true
print(Solution().checkSubarraySum([23,2,6,4,7], 6)) //true
print(Solution().checkSubarraySum([23,2,6,4,7], 13)) //false
print(Solution().checkSubarraySum([5,0,0,0], 3)) //true
print(Solution().checkSubarraySum([23,2,4,6,6], 7)) //true
print(Solution().checkSubarraySum([1,2,12], 12)) //false
