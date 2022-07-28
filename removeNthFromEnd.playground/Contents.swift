//Given the head of a linked list, remove the nth node from the end of the list and return its head.
//


public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
    let newHead = head

    var map = [Int: ListNode]()
    var curHead = head
    var length = 0
    while curHead != nil {
        map[length] = curHead
        length = length + 1
        curHead = curHead?.next
    }
    
    let positionToRemove = length - n
    if positionToRemove == 0 {
        return head?.next
    } else {
        map[positionToRemove - 1]?.next = map[positionToRemove]?.next
    }
    
    return newHead
}


var remove = removeNthFromEnd(ListNode(1, ListNode(2, ListNode(3, ListNode(4, ListNode(5))))), 2)
while remove != nil {
    print(remove?.val, separator: ", ", terminator: "")
    remove = remove?.next
}

print("\nTest2:")
remove = removeNthFromEnd(ListNode(1), 1)
while remove != nil {
    print(remove?.val, separator: ", ", terminator: "")
    remove = remove?.next
}

