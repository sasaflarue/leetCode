//You are given the heads of two sorted linked lists list1 and list2.
//
//Merge the two lists in a one sorted list. The list should be made by splicing together the nodes of the first two lists.
//
//Return the head of the merged linked list.


public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}
    
class Solution {
    static func mergeTwoLists(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {
        
        if list1 == nil {
            return list2
        } else if list2 == nil {
            return list1
        }
        
        guard let list1 = list1,
            let list2 = list2 else {
            return ListNode()
        }
        
        var newHead: ListNode?
        var list1Iterator: ListNode? = list1
        var list2Iterator: ListNode? = list2
        if list1.val < list2.val {
            newHead = ListNode(list1.val)
            list1Iterator = list1Iterator?.next
        } else {
            newHead = ListNode(list2.val)
            list2Iterator = list2Iterator?.next
        }
        
        var current = newHead
        
        while list1Iterator?.next != nil || list1Iterator?.val != nil || list2Iterator?.next != nil || list2Iterator?.val != nil {
            print("In loop")
            guard let list1Val = list1Iterator?.val else {
                if let list2Val = list2Iterator?.val {
                    print("debug1")
                    current?.next = ListNode(list2Val)
                    current = current?.next
                    list2Iterator = list2Iterator?.next
                }
                continue
            }
            
            print("In2")
            guard let list2Val = list2Iterator?.val else {
                if let list1Val = list1Iterator?.val {
                    print("debug2")
                    current?.next = ListNode(list1Val)
                    current = current?.next
                    list1Iterator = list1Iterator?.next
                }
                continue
            }
            
            print("In3")
            if list1Val < list2Val {
                current?.next = ListNode(list1Val)
                current = current?.next
                list1Iterator = list1Iterator?.next
            } else {
                print("In3")
                current?.next = ListNode(list2Val)
                current = current?.next
                list2Iterator = list2Iterator?.next
            }
            print(list1Iterator?.next)
        }
        return newHead
    }
}


let list1 = ListNode(1, ListNode(2, ListNode(4)))
let list2 = ListNode(1, ListNode(3, ListNode(4)))

print(Solution.mergeTwoLists(list1, list2))
