//Given a string s which consists of lowercase or uppercase letters, return the length of the longest palindrome that can be built with those letters.
//
//Letters are case sensitive, for example, "Aa" is not considered a palindrome here.

import Foundation

class Solution {
    static func longestPalindrome(_ s: String) -> Int {
        var uniqueLetters = 0
        var letterMap = [Character: Int]()
        
        guard s.count > 1 else {
            return 1
        }
        
        s.forEach {
            letterMap[$0] = (letterMap[$0] ?? 0) + 1
        }
        
        var leftOver = 0
        letterMap.forEach {
            uniqueLetters = uniqueLetters + $0.value / 2
            if leftOver == 0 && $0.value % 2 > 0 {
                leftOver = 1
            }
        }
        
        return uniqueLetters * 2 + leftOver
        
//        var leftovers = [Character]()
//        var pivotCharacterLength = 0
//        letterMap.forEach {
//            let currentCharacter = $0.value / 2
//            uniqueLetters = uniqueLetters + currentCharacter
//
//            let currentPivotLength = (pow(2, currentCharacter + 1) as NSDecimalNumber).intValue - 1
//            if $0.value % 2 > 0 && currentPivotLength > pivotCharacterLength {
//                pivotCharacterLength = currentPivotLength
//            }
//        }
//        let palindromeWord = (pow(2, uniqueLetters) as NSDecimalNumber).intValue - 1
//        return palindromeWord + pivotCharacterLength
    }
}


let s = "abccccdd" // 7
print(Solution.longestPalindrome(s))

let s2 = "a" // 1
print(Solution.longestPalindrome(s2))

let s3 = "bb" // 2
print(Solution.longestPalindrome(s3))

let s4 = "bbb" // 3
print(Solution.longestPalindrome(s4))
