//Given two strings s and t, return true if s is a subsequence of t, or false otherwise.
//
//A subsequence of a string is a new string that is formed from the original string by deleting some (can be none) of the characters without disturbing the relative positions of the remaining characters. (i.e., "ace" is a subsequence of "abcde" while "aec" is not).

class Solution {
    static func isSubsequence(_ s: String, _ t: String) -> Bool {
        guard s.count > 0 else {
            return true
        }
        let requiredLetters = Array(s)
        var currentRequired = 0
        for letter in t {
            if currentRequired == requiredLetters.count {
                return true
            }
            if letter == requiredLetters[currentRequired] {
                currentRequired += 1
            }
        }
        return currentRequired == requiredLetters.count
    }
}

//print(Solution.isSubsequence("abc","ahbgdc"))
//print(Solution.isSubsequence("","ahbgdc"))
print(Solution.isSubsequence("b","abc"))
