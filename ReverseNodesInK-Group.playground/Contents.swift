import Foundation

/*
 Given the head of a linked list, reverse the nodes of the list k at a time, and return the modified list.

 k is a positive integer and is less than or equal to the length of the linked list. If the number of nodes is not a multiple of k then left-out nodes, in the end, should remain as it is.

 You may not alter the values in the list's nodes, only nodes themselves may be changed.

  

 Example 1:
 Input: head = [1,2,3,4,5], k = 2
 Output: [2,1,4,3,5]
 
 Input: head = [1,2,3,4,5], k = 3
 Output: [3,2,1,4,5]
 
 The number of nodes in the list is n.
 1 <= k <= n <= 5000
 0 <= Node.val <= 1000
 
 
 */

 public class ListNode {
     public var val: Int
     public var next: ListNode?
     public init() { self.val = 0; self.next = nil; }
     public init(_ val: Int) { self.val = val; self.next = nil; }
     public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
 }

class Solution {
//    func reverseKGroup(_ head: ListNode?, _ k: Int) -> ListNode? {
//        var toSwap = [ListNode]()
//        var newHead: ListNode? = nil
//        var pivot: ListNode? = nil
//        var curHead = head
//        
//        while curHead != nil {
//            while toSwap.count < k {
//                toSwap.append(curHead!)
//                curHead = curHead!.next
//                toSwap.forEach { node in
//                    print("\(node.val)")
//                }
//                if toSwap.count < k && curHead?.next == nil {
//                    if let curHead {
//                        toSwap.append(curHead)
//                    }
//                    curHead = nil
//                    print(("break"))
//                    //just remaining append these to the end
//                    break
//                }
//                print("toswap count \(toSwap.count)")
//            }
//            
//            if toSwap.count < k {
//                print("less than k")
//                pivot?.next = toSwap.first
//                return newHead
//            } else {
//                print("here")
//                while !toSwap.isEmpty {
//                    
//                    if newHead == nil && !toSwap.isEmpty {
//                        newHead = toSwap.popLast()!
//                        pivot = newHead
//                        print("once")
//                    } else {
//                        pivot?.next = toSwap.popLast()
//                        pivot = pivot?.next
//                    }
//                }
//            }
//            
//        }
//        pivot?.next = nil
//        
//        return newHead
//    }
    
    func reverseKGroup(_ head: ListNode?, _ k: Int) -> ListNode? {
        var toSwap = [ListNode]()
        var newHead: ListNode? = nil
        var pivot: ListNode? = nil
        var curHead = head
        
        while curHead != nil {
            while toSwap.count < k {
                toSwap.append(curHead!)
                curHead = curHead!.next
                // toSwap.forEach { node in
                //     print("\(curHead?.val)")
                // }
                if toSwap.count < k && curHead?.next == nil {
                    if let curHead {
                        toSwap.append(curHead)
                    }
                    curHead = nil
                    //just remaining append these to the end
                    break
                }
    
            }
            
            if toSwap.count < k {
                pivot?.next = toSwap.first
                return newHead
            } else {
                
                while !toSwap.isEmpty {
                    
                    if newHead == nil && !toSwap.isEmpty {
                        newHead = toSwap.popLast()!
                        pivot = newHead
                    } else {
                        pivot?.next = toSwap.popLast()
                        pivot = pivot?.next
                    }
                }
            }
        }
        
        pivot?.next = nil
        
        return newHead
    }
}

//let list = ListNode(1,  ListNode(2, ListNode(3, ListNode(4, ListNode(5)))))
let list = ListNode(1,  ListNode(2))
var solution = Solution().reverseKGroup(list, 2)
while solution?.next != nil {
    print(solution?.val)
    solution = solution?.next
}
print(solution?.val)

