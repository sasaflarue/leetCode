/*
 Given an integer array nums, return all the triplets [nums[i], nums[j], nums[k]] such that i != j, i != k, and j != k, and nums[i] + nums[j] + nums[k] == 0.

 Notice that the solution set must not contain duplicate triplets.

 Example 1:
 Input: nums = [-1,0,1,2,-1,-4]
 Output: [[-1,-1,2],[-1,0,1]]
 Explanation:
 nums[0] + nums[1] + nums[2] = (-1) + 0 + 1 = 0.
 nums[1] + nums[2] + nums[4] = 0 + 1 + (-1) = 0.
 nums[0] + nums[3] + nums[4] = (-1) + 2 + (-1) = 0.
 The distinct triplets are [-1,0,1] and [-1,-1,2].
 Notice that the order of the output and the order of the triplets does not matter.

 Example 2:
 Input: nums = [0,1,1]
 Output: []
 Explanation: The only possible triplet does not sum up to 0.

 Example 3:
 Input: nums = [0,0,0]
 Output: [[0,0,0]]
 Explanation: The only possible triplet sums up to 0.

 Constraints:

     3 <= nums.length <= 3000
     -105 <= nums[i] <= 105
 */

func threeSum(_ nums: [Int]) -> [[Int]] {
    var combos = [[Int]]()
    
    var firstIterator = 0
    var secondIterator = 1
    var thirdIterator = 2
    var added = Set<[Int]>()
    let sortedNums = nums.sorted()
    
    
    while firstIterator < nums.count - 2 {
        let first = sortedNums[firstIterator]
        if first > 0 { break }
        while secondIterator < nums.count - 1 {
            let second = sortedNums[secondIterator]
            if firstIterator > 0 && sortedNums[firstIterator] == sortedNums[firstIterator - 1] { continue }

            while thirdIterator < nums.count {
                let third = sortedNums[thirdIterator]
//                print("first \(first), second \(second), third \(third)")
                if first + second + third == 0 {
                    // need to check if unique here
                    let sorted = [first, second, third]
                    if !added.contains(sorted) {
                        combos.append(sorted)
                        added.insert(sorted)
                    }
                }
                thirdIterator += 1
            }
            secondIterator += 1
            thirdIterator = secondIterator + 1
        }
        firstIterator += 1
        secondIterator = firstIterator + 1
        thirdIterator = secondIterator + 1
        
    }
    return combos
}

//print(threeSum( [0,0,0]))
//print(threeSum([-1,0,1,2,-1,-4])) // [[-1,-1,2],[-1,0,1]]
//print(threeSum([0,1,1])) // []
//print(threeSum([0,0,0,0])) // [0, 0, 0]
//print(threeSum([-100,-70,-60,110,120,130,160])) // [[-100,-60,160],[-70,-60,130]]
print(threeSum([0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]))
