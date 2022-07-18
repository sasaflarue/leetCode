//Given an array of integers nums which is sorted in ascending order, and an integer target, write a function to search target in nums. If target exists, then return its index. Otherwise, return -1.
//
//You must write an algorithm with O(log n) runtime complexity.


class Solution {
    static func search(_ nums: [Int], _ target: Int) -> Int {
        let count = nums.count
        let pivot = count / 2
        if nums.first == target {
            return 0
        } else if nums.count == 2 && nums[1] == target {
            return 1
        } else if nums.count <= 2 {
            return -1
        } else if nums[pivot] == target {
            return pivot
        } else if nums[pivot] > target {
            return search(Array(nums[0...pivot]), target)
        } else if nums[pivot] < target {
            let found = search(Array(nums[pivot...nums.count-1]), target)
            return found != -1 ? found + pivot : -1
        }
        return -1
    }
}


let nums = [-1,0,3,5,9,12]
let target = 9
print(Solution.search(nums, target))


let nums2 = [-1,0,3,5,9,12]
let target2 = 52
print(Solution.search(nums2, target2))

let nums3 = [-1,0,3,5,9,12]
let target3 = 2
print(Solution.search(nums3, target3))


let nums4 = [5]
let target4 = -5
print(Solution.search(nums4, target4))


