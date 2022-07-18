//Given the head of a singly linked list, return the middle node of the linked list.
//
//If there are two middle nodes, return the second middle node.

import Foundation




public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

class Solution {
    static func middleNode(_ head: ListNode?) -> ListNode? {
        var nodeMap = [Int: ListNode]()
        var iterator = head
        var lengthOfList = 0
        repeat {
            nodeMap[lengthOfList] = iterator
            lengthOfList = lengthOfList + 1
            iterator = iterator?.next
        }  while iterator != nil
        return nodeMap[lengthOfList/2]
    }
}

print(Solution.middleNode(ListNode(1))?.val)

print(Solution.middleNode(ListNode(1, ListNode(2, ListNode(3, ListNode(4, ListNode(5, nil))))))?.val)
print(Solution.middleNode(ListNode(1, ListNode(2, ListNode(3, ListNode(4, ListNode(5, ListNode(6)))))))?.val)
