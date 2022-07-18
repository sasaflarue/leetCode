//Given the head of a linked list, return the node where the cycle begins. If there is no cycle, return null.
//
//There is a cycle in a linked list if there is some node in the list that can be reached again by continuously following the next pointer. Internally, pos is used to denote the index of the node that tail's next pointer is connected to (0-indexed). It is -1 if there is no cycle. Note that pos is not passed as a parameter.
//
//Do not modify the linked list.

import Foundation

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
    
    public init(_ val: Int, next: ListNode) {
        self.val = val
        self.next = next
    }
}

class Solution {
    var pos = -1
    
    static func detectCycle(_ head: ListNode?) -> ListNode? {
        var nodeMap = [ListNode]()
        var newHead = head
        
        while newHead != nil {
            let existsIndex = nodeMap.firstIndex { Unmanaged.passUnretained($0).toOpaque() == Unmanaged.passUnretained(newHead!).toOpaque() }

            if let exists = existsIndex {
                print("exists: \(exists)")
                return newHead
            } else {
                print("appending \(newHead?.val)")
                guard let newHead = newHead else {
                    return nil
                }
                nodeMap.append(newHead)
            }
            newHead = newHead?.next
        }
        
        return nil
    }
}

var last = ListNode(-4)
var cycle = ListNode(2, next: ListNode(0, next: last))
let first = ListNode(3, next: cycle)
last.next = cycle

print(Solution.detectCycle(first)?.val)


//[-1,-7,7,-4,19,6,-9,-5,-2,-5]
var last2 = ListNode(-5)
var cycle2 = ListNode(-9, next: ListNode(-5, next: ListNode(-2, next: last2)))
let first2 = ListNode(-1, next: ListNode(-7, next: ListNode(7, next: ListNode(-4, next: ListNode(19, next: ListNode(6, next: cycle2))))))
last2.next = cycle

print(Solution.detectCycle(first2)?.val)
