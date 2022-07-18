//Given the head of a singly linked list, reverse the list, and return the reversed list.

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}
 
class Solution {
    static func reverseList(_ head: ListNode?) -> ListNode? {
        guard let headVal = head?.val else {
            return nil
        }
        var previousNode = head
        var newHead: ListNode? = ListNode(headVal)
        var nextNode = head?.next
        while nextNode != nil {
            newHead = ListNode(nextNode!.val, newHead)
            nextNode = nextNode?.next
        }
        return newHead
    }
}
let list = ListNode(1, ListNode(2, ListNode(3, ListNode(4, ListNode(5)))))

var reversed = Solution.reverseList(list)
while reversed?.next != nil {
    print(reversed?.val)
    reversed = reversed?.next
}
