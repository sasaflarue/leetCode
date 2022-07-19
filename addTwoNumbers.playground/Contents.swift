//You are given two non-empty linked lists representing two non-negative integers. The digits are stored in reverse order, and each of their nodes contains a single digit. Add the two numbers and return the sum as a linked list.
//
//You may assume the two numbers do not contain any leading zero, except the number 0 itself.


public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

class Solution {
    static func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var l1Iterator = l1
        var l2Iterator = l2
        
        var head: ListNode?
        var current: ListNode?
        var carry: Int?
        
        if l1Iterator != nil || l2Iterator != nil {
            var val = (l1Iterator?.val ?? 0) + (l2Iterator?.val ?? 0) + (carry ?? 0)
            
            if val == 10 {
                val = 0
                carry = 1
            } else if val > 10 {
                val = val % 10
                carry = 1
            } else {
                carry = 0
            }
            head = ListNode(val)
        } else {
            return nil
        }
        
        l1Iterator = l1Iterator?.next
        l2Iterator = l2Iterator?.next
        current = head
    
        while l1Iterator != nil || l2Iterator != nil || carry ?? 0 > 0 {
            var val = (l1Iterator?.val ?? 0) + (l2Iterator?.val ?? 0) + (carry ?? 0)
            if val == 10 {
                val = 0
                carry = 1
            } else if val > 10 {
                val = val % 10
                carry = 1
            } else {
                carry = 0
            }
            current?.next = ListNode(val)
            current = current?.next
            l1Iterator = l1Iterator?.next
            l2Iterator = l2Iterator?.next
        }
        
        return head
        
        
        // doesnt work for large lists
        
//        var total = sumNode(l1) + sumNode(l2)
//        let lastDigit = total % 10
//        total = total / 10
//        let tail = ListNode(lastDigit)
//        var curHead: ListNode? = tail
//        while total > 0 {
//            let lastDigit = total % 10
//            total = total / 10
//            curHead?.next = ListNode(lastDigit)
//            curHead = curHead?.next
//        }
//
//        return tail
    }
    
    static func sumNode(_ node: ListNode?) -> Int {
        guard let node = node else { return 0 }
        return node.val + 10 * sumNode(node.next)
    }
}

let l1 = ListNode(9, ListNode(9, ListNode(9, ListNode(9, ListNode(9, ListNode(9, ListNode(9, ListNode(9))))))))//[2,4,3]
let l2 = ListNode(9, ListNode(9, ListNode(9, ListNode(9))))//[5,6,4]

var solution = Solution.addTwoNumbers(l1, l2)
repeat {
    print(solution?.val)
    solution = solution?.next
} while solution != nil
