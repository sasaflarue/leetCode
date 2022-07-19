//Given a string containing digits from 2-9 inclusive, return all possible letter combinations that the number could represent. Return the answer in any order.
//
//A mapping of digits to letters (just like on the telephone buttons) is given below. Note that 1 does not map to any letters.

func letterCombinations(_ digits: String) -> [String] {
    // 2 abc
    // 3 def
    // 4 ghi
    // 5 jkl
    // 6 mno
    // 7 pqrs
    // 8 tuv
    // 9 wxyz
    var combinations = [String]()
    var possibilities = [[String]]()
    for (index, item) in digits.enumerated() {
        possibilities.append(getPossibilities(item))
    }
    
    return createCombos(possibilities) ?? [String]()
}

func createCombos(_ possibilities: [[String]]) -> [String]? {
    guard !possibilities.isEmpty else { return nil }
    var newPossibilities = possibilities
    
    var comboList: [String]? = [String]()
    let first = newPossibilities.first
    newPossibilities.removeFirst()
    first?.forEach({ char in
        //        print(char)
        if let combos = createCombos(newPossibilities) {
            combos.forEach { char2 in
                comboList?.append(char + char2)
            }
        } else {
            comboList = first
        }
    })
    return comboList
}

func getPossibilities(_ char: String.Element) -> [String] {
    switch char {
    case "2":
        return ["a", "b", "c"]
    case "3":
        return ["d", "e", "f"]
    case "4":
        return ["g", "h", "i"]
    case "5":
        return ["j", "k", "l"]
    case "6":
        return ["m", "n", "o"]
    case "7":
        return ["p", "q", "r", "s"]
    case "8":
        return ["t", "u", "v"]
    case "9":
        return ["w", "x", "y", "z"]
    default:
        return [String]()
        
    }
}


print(letterCombinations("23"))
