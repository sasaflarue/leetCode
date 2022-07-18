//You are a product manager and currently leading a team to develop a new product. Unfortunately, the latest version of your product fails the quality check. Since each version is developed based on the previous version, all the versions after a bad version are also bad.
//
//Suppose you have n versions [1, 2, ..., n] and you want to find out the first bad one, which causes all the following ones to be bad.
//
//You are given an API bool isBadVersion(version) which returns whether version is bad. Implement a function to find the first bad version. You should minimize the number of calls to the API.

import Darwin


/**
 * The knows API is defined in the parent class VersionControl.
 *     func isBadVersion(_ version: Int) -> Bool{}
 */

class Solution {
    private static func isBadVersion(_ version: Int) -> Bool {
         version >= 4 ? true : false
    }
    
    static func firstBadVersion(_ n: Int) -> Int {
//        var pivot = n / 2
//        var foundFirst: Int?
//        guard n > 1  else {
//         return 1
//        }
//        repeat {
//            print(pivot)
//            if isBadVersion(pivot) {
//                if !isBadVersion(pivot - 1) {
//                    foundFirst = pivot
//                    print("FOUND")
//                }
//                pivot = pivot / 2
//            } else {
//                let tempPivot = pivot + Int(ceil(Double((n - pivot)) / 2.0)) // 51 + (1) / 2
//                pivot = tempPivot > n  ? n - 1 : tempPivot
//            }
//        } while foundFirst == nil
//
//        return foundFirst ?? n
        
        var right = n, left = 1
           while left < right {
               var mid = (left + right) / 2
               if isBadVersion(mid) {
                   right = mid
               } else {
                   left = mid + 1
               }
           }
           return left
    }
}



print(Solution.firstBadVersion(5))

//2126753390
//1702766719

