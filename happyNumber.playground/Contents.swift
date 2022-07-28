//Write an algorithm to determine if a number n is happy.
//
//A happy number is a number defined by the following process:
//
//    Starting with any positive integer, replace the number by the sum of the squares of its digits.
//    Repeat the process until the number equals 1 (where it will stay), or it loops endlessly in a cycle which does not include 1.
//    Those numbers for which this process ends in 1 are happy.
//
//Return true if n is a happy number, and false if not.

import Darwin

func isHappy(_ n: Int) -> Bool {
    var sums = [Int: Bool]()
    var curSum = sumOfSquares(n)
    
    while sums[curSum] != true {
        if calulateHappy(curSum) {
            return true
        }
        sums[curSum] = true
        curSum = sumOfSquares(curSum)
    }
    return false
}

func sumOfSquares(_ n: Int) -> Int {
    var total = 0
    String(n).forEach { char in
        let p = pow(Double("\(char)") ?? 0, 2)
        total = total + Int(p)
    }
    
    return total
}

func calulateHappy(_ n: Int) -> Bool {
    var curNumber = n
    
    while curNumber > 1 {
        if curNumber % 10 != 0 {
            return false
        } else {
            curNumber = curNumber / 10
        }
    }
    
    return curNumber == 1
}

print(isHappy(100)) // true
print(isHappy(2)) // false
print(isHappy(101)) // false
print(isHappy(19)) // true
