//Given two strings s and t, determine if they are isomorphic.
//
//Two strings s and t are isomorphic if the characters in s can be replaced to get t.
//
//All occurrences of a character must be replaced with another character while preserving the order of characters. No two characters may map to the same character, but a character may map to itself.

class Solution {
    static func isIsomorphic(_ s: String, _ t: String) -> Bool {
        guard s.count == t.count else {
            return false
        }
        let tArray = Array(t)
        var mappedLetters = [Character: Character]()
        
        for (index, item) in s.enumerated() {
            let tLetter = tArray[index]
            
            if let curLetter = mappedLetters[item] {
                if curLetter == tLetter {
                    continue
                } else {
                    return false
                }
            } else {
                if mappedLetters.values.contains(tLetter) {
                    return false
                } else {
                    mappedLetters[item] = tLetter
                }
            }
            
            
            
            
//            if mappedLetters[item] != nil && mappedLetters[item] != tLetter {
//                return false
//            }
//
//            if mappedLetters.contains(where: { ($0.value == item) || ($0.value == tLetter && $0.key != item)}) {
//                print(index)
//                print("item is \(item) and tLetter \(tLetter)")
//                print(mappedLetters)
//                return false
//            }
//
//            mappedLetters[item] = tLetter
        }
        return true
    }
}


print(Solution.isIsomorphic("badc", "baba")) //false
print(Solution.isIsomorphic("egg", "add")) // true
print(Solution.isIsomorphic("abab", "baba")) // true
print(Solution.isIsomorphic("qwertyuiop[]asdfghjkl;'\\zxcvbnm,./","',.pyfgcrl/=aoeuidhtns-\\;qjkxbmwvz")) // true

