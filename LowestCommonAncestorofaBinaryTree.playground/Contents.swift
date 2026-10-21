import Foundation

/*
 Given a binary tree, find the lowest common ancestor (LCA) of two given nodes in the tree.

 According to the definition of LCA on Wikipedia: “The lowest common ancestor is defined between two nodes p and q as the lowest node in T that has both p and q as descendants (where we allow a node to be a descendant of itself).”

 Example 1:

 Input: root = [3,5,1,6,2,0,8,null,null,7,4], p = 5, q = 1
 Output: 3
 Explanation: The LCA of nodes 5 and 1 is 3.

 Example 2:

 Input: root = [3,5,1,6,2,0,8,null,null,7,4], p = 5, q = 4
 Output: 5
 Explanation: The LCA of nodes 5 and 4 is 5, since a node can be a descendant of itself according to the LCA definition.

 Example 3:

 Input: root = [1,2], p = 1, q = 2
 Output: 1


 Constraints:

     The number of nodes in the tree is in the range [2, 105].
     -109 <= Node.val <= 109
     All Node.val are unique.
     p != q
     p and q will exist in the tree.

 */

public class TreeNode {
      public var val: Int
      public var left: TreeNode?
      public var right: TreeNode?
      public init(_ val: Int) {
          self.val = val
          self.left = nil
          self.right = nil
      }
    public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?){
        self.val = val
        self.left = left
        self.right = right
    }
}

extension TreeNode: Equatable {
    public static func == (lhs: TreeNode, rhs: TreeNode) -> Bool {
//        lhs.left == rhs.left && lhs.right == rhs.right && lhs.val == rhs.val
        lhs.val == rhs.val
    }
}
 

class Solution {
    func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        guard let p, let q else { return nil }
        let pPath = findPath(root, p)
        let qPath = findPath(root, q)
    
        var lowestCommonAncestor = pPath?.first
        var iterator = 0
        
        while iterator >= 0 {
            if let pPath, let qPath,
                iterator < pPath.count, iterator < qPath.count,
                pPath[iterator] == qPath[iterator] {
                lowestCommonAncestor = pPath[iterator]
                iterator += 1
            } else {
                return lowestCommonAncestor
            }
        }
        return nil
    }
    
    func findPath(_ root: TreeNode?, _ p: TreeNode)  -> [TreeNode]? {
        guard let root else { return nil }
        if p == root  {
            print("finding path root")
            return [root]
        } else {
            let pathLeft = findPath(root.left, p)
            let pathRight = findPath(root.right, p)
            
            if let pathLeft {
                return [root] + pathLeft
            } else if let pathRight {
                return [root] + pathRight
            } else {
                return nil
            }
        }
    }
}

//3,5,1,6,2,0,8,null,null,7,4]
let root = TreeNode(3, TreeNode(5, TreeNode(6), TreeNode(2, TreeNode(7), TreeNode(4))), TreeNode(1, TreeNode(0), TreeNode(8)))
//print(Solution().lowestCommonAncestor(root, TreeNode(5), TreeNode(1))?.val)
print(Solution().lowestCommonAncestor(root, TreeNode(5), TreeNode(4))?.val)
