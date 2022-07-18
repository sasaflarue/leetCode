//Given a binary search tree (BST), find the lowest common ancestor (LCA) of two given nodes in the BST.
//
//According to the definition of LCA on Wikipedia: “The lowest common ancestor is defined between two nodes p and q as the lowest node in T that has both p and q as descendants (where we allow a node to be a descendant of itself).”



public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
    public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}


class Solution {
    static func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        
        var pPath: [TreeNode]? = nil
        var qPath: [TreeNode]? = nil
        if let p = p {
            pPath = findPath(root, p)
        }
        
        if let q = q {
            qPath = findPath(root, q)
        }
        var lca: TreeNode? = root
        pPath?.forEach {
            let curNode = $0
            if let curLast = qPath?.last(where: { node in
                node.val == curNode.val
            }) {
                lca = curLast
            }
        }
        
        
        return lca
    }
    
    static func findPath(_ root: TreeNode?, _ end: TreeNode) -> [TreeNode]? {
        guard let root = root else {
            return nil
        }
        
        if root.val == end.val {
            return [root]
        }
        
        let left = findPath(root.left, end)
        let right = findPath(root.right, end)
        var rootArr = [root]
        if !(left?.isEmpty ?? true) {
            rootArr.append(contentsOf: left!)
            return rootArr
        } else if !(right?.isEmpty  ?? true) {
            rootArr.append(contentsOf: right!)
            return rootArr
        } else {
            return nil
        }
    }
}

//[6,2,8,0,4,7,9,null,null,3,5], p = 2, q = 8
let p = TreeNode(2, TreeNode(0), TreeNode(4, TreeNode(3), TreeNode(5)))
let q = TreeNode(8, TreeNode(7), TreeNode(9))
let root = TreeNode(2, p, q)
print(Solution.lowestCommonAncestor(root, p, q)?.val)
