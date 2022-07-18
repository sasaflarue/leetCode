//Given an array of integers nums and an integer target, return indices of the two numbers such that they add up to target.
//
//You may assume that each input would have exactly one solution, and you may not use the same element twice.
//
//You can return the answer in any order.
//
//Input: nums = [2,7,11,15], target = 9
//Output: [0,1]
//Explanation: Because nums[0] + nums[1] == 9, we return [0, 1].

class Solution {
    static func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        for (index, item) in nums.enumerated() {
            let checkNums = nums[index+1...nums.count-1]
            for (checkIndex, checkItem) in checkNums.enumerated() {
                if item + checkItem == target {
                    return [index, index+checkIndex+1]
                }
            }
        }
        return [-1, -1]
    }
}

print(Solution.twoSum([2,7,11,15], 9))
