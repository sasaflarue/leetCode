import Foundation

/*
 Given the root of a binary tree, return the level order traversal of its nodes' values. (i.e., from left to right, level by level).

  

 Example 1:

 Input: root = [3,9,20,null,null,15,7]
 Output: [[3],[9,20],[15,7]]

 Example 2:

 Input: root = [1]
 Output: [[1]]

 Example 3:

 Input: root = []
 Output: []

  

 Constraints:

     The number of nodes in the tree is in the range [0, 2000].

 */


  public class TreeNode {
      public var val: Int
      public var left: TreeNode?
      public var right: TreeNode?
      public init() { self.val = 0; self.left = nil; self.right = nil; }
      public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
      public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
          self.val = val
          self.left = left
          self.right = right
      }
  }

class Solution {
    func levelOrder(_ root: TreeNode?) -> [[Int]] {
        guard let root = root else { return [] }
        var toTraverse: [TreeNode] = [root]
        var inOrder = [[Int]]()
        var curLevel = [Int]()
        var nextLevel = [TreeNode]()
        
        while !toTraverse.isEmpty {
            
            let current = toTraverse.removeFirst()
            curLevel.append(current.val)
            
            if let left = current.left {
                nextLevel.append(left)
            }
            
            if let right = current.right {
                nextLevel.append(right)
            }
            
            if toTraverse.isEmpty {
                inOrder.append(curLevel)
                curLevel = [Int]()
                toTraverse = nextLevel
                nextLevel = [TreeNode]()
            }
        }
        
        
        return inOrder
    }
}
