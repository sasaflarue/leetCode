import UIKit
/*
 
 3. Longest Substring Without Repeating Characters
 Medium
 Topics
 premium lock iconCompanies
 Hint

 Given a string s, find the length of the longest without duplicate characters.

 Example 1:

 Input: s = "abcabcbb"
 Output: 3
 Explanation: The answer is "abc", with the length of 3. Note that "bca" and "cab" are also correct answers.

 Example 2:

 Input: s = "bbbbb"
 Output: 1
 Explanation: The answer is "b", with the length of 1.

 Example 3:

 Input: s = "pwwkew"
 Output: 3
 Explanation: The answer is "wke", with the length of 3.
 Notice that the answer must be a substring, "pwke" is a subsequence and not a substring.

  

 Constraints:

     0 <= s.length <= 5 * 104
     s consists of English letters, digits, symbols and spaces.

 */


func lengthOfLongestSubstring(_ s: String) -> Int {
    var longest = 0
    var currentStart = 0
    let arrayString = Array(s)
    
    while currentStart < s.count {
        var currentEnd = currentStart
        while currentEnd < s.count {
            //get a substring of start to end
            let currentSubstring = arrayString[currentStart...currentEnd]
            var currentLongest = 0
            //check that all the characters are unique in that substring
            var usedCharacters = [String]()
            var isUnique = true
            currentSubstring.forEach { char in
                print(char)
                if usedCharacters.contains("\(char)") {
                    isUnique = false
                } else if (isUnique) {
                    usedCharacters.append("\(char)")
                    print(isUnique)
                    currentLongest += 1
                }
            }
            longest = max(currentLongest, longest)
            currentEnd += 1
        }
        currentStart += 1
            
        //if they are then set longest if it's greater
        
        //if they are not unique increment the current start
    }
    
    print("longest: \(longest)")
    return longest
}

    
print(lengthOfLongestSubstring("abcabcbb") == 3)
print(lengthOfLongestSubstring("bbbbb") == 1)
print(lengthOfLongestSubstring("pwwkew") == 3)
