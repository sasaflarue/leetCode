//Given an integer x, return true if x is palindrome integer.
//
//An integer is a palindrome when it reads the same backward as forward.
//
//    For example, 121 is a palindrome while 123 is not.
//                                    Input: x = 121
//                                    Output: true
//                                    Explanation: 121 reads as 121 from left to right and from right to left.

class Solution {
     static func isPalindrome(_ x: Int) -> Bool {
        let stringify = "\(x)"
        var endCharacters = stringify
        for (index, item) in stringify.enumerated() {
            if index >= stringify.count / 2 {
                return true
            }
            if item == endCharacters.last {
                endCharacters.removeLast()
            } else {
                return false
            }
        }
         return false
    }
}

print(Solution.isPalindrome(0))
