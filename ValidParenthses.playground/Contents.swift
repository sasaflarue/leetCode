import Foundation


/*
 Given a string s containing just the characters '(', ')', '{', '}', '[' and ']', determine if the input string is valid.

 An input string is valid if:

     Open brackets must be closed by the same type of brackets.
     Open brackets must be closed in the correct order.
     Every close bracket has a corresponding open bracket of the same type.

 Example 1:

 Input: s = "()"
 Output: true

 Example 2:
 Input: s = "()[]{}"
 Output: true

 Example 3:
 Input: s = "(]"
 Output: false
 
 Example 4:

 Input: s = "([])"
 Output: true

 Example 5:
 Input: s = "([)]"
 Output: false
 Constraints:

     1 <= s.length <= 104
     s consists of parentheses only '()[]{}'.

 */

class Solution {
    private let pairs: [Character: Character] = [
        "{": "}",
        "[": "]",
        "(": ")",
    ]
    private let openings: [Character] = ["{", "[", "("]
    
    func isValid(_ s: String) -> Bool {
        guard s.count % 2 == 0 else { return false }
        var stack = [Character]()
        
        for i in 0..<s.count {
            let element = s[s.index(s.startIndex, offsetBy: i)]
            if stack.count == 0 {
                stack.append(element)
            } else {
//                print("last \(stack.last)")
//                print( pairs[element])
                if let last = stack.last,
                   pairs[last] == element {
//                    print("popping")
                    stack.popLast()
                } else if openings.contains(element){
//                    print("adding")
                    stack.append(element)
                }else {
                    return false
                }
            }
        }
        
        return stack.count == 0
    }
}


print(Solution().isValid("(]"))
print(Solution().isValid("()"))
print(Solution().isValid("([}}])"))
