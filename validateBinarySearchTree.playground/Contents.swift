//Given the root of a binary tree, determine if it is a valid binary search tree (BST).
//
//A valid BST is defined as follows:
//
//    The left subtree of a node contains only nodes with keys less than the node's key.
//    The right subtree of a node contains only nodes with keys greater than the node's key.
//    Both the left and right subtrees must also be binary search trees


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
    
//    static func preorder(_ root: TreeNode?) -> [Int] {
//        var arr = [Int]()
////        print(root?.val)
//        if root?.children.isEmpty == true,
//           let val = root?.val {
////            print(val)
//           return [val]
//        } else if let root = root {
//            arr.append(root.val)
//            root.children.forEach {
//                arr.append(contentsOf: preorder($0))
//            }
//        }
//
//        return arr
//    }
    
    static func isValidBST(_ root: TreeNode?) -> Bool {
        guard let root = root else {
             return true
        }
        
        var previous = Int.min
        let inordered = inOrder(root)
        
        for (_, item) in inordered.enumerated() {
            if item <= previous {
                return false
            }
            previous = item
        }
        
        return true
        
    }
    
    static func inOrder(_ root: TreeNode?) -> [Int] {
        var arr = [Int]()
        guard let root = root else {
            return  arr
        }
        
        arr.append(contentsOf: inOrder(root.left))
        arr.append(root.val)
        arr.append(contentsOf: inOrder(root.right))

        return arr
    }
    
    
    
    
    static func isValidBSTold(_ root: TreeNode?) -> Bool {
        guard let root = root else {
            return true
        }
        
        if let left = root.left?.val,
           left >= root.val {
//            print("here0")
            return false
        }

        if let right = root.right?.val,
           right <= root.val {
//            print("here1")
            return false
        }
        
        var leftTreeNode: TreeNode? = root.left
        var rightTreeNode: TreeNode? = root.right
        if let left = root.left {
            let newRoot = root.val > left.val ? root.val : left.val
            leftTreeNode = TreeNode(newRoot, left.left, TreeNode(root.val))
        }

        if let right = root.right {
            let newRoot = root.val < right.val ? root.val : right.val
//            print(newRoot)
            rightTreeNode = TreeNode(newRoot, TreeNode(root.val), right.right)
        }
        
        return isLeft(leftTreeNode) && isRight(rightTreeNode)
    }
    
    static func isLeft(_ root: TreeNode?) -> Bool {
        guard let root = root else {
            return true
        }
        
        if let left = root.left?.val,
           left >= root.val {
//            print("here0")
            return false
        }
        
        var leftTreeNode: TreeNode? = root.left
        var rightTreeNode: TreeNode? = root.right
        if let left = root.left {
            let newRoot = root.val > left.val ? root.val : left.val
            leftTreeNode = TreeNode(newRoot, left.left, TreeNode(root.val))
        }

        if let right = root.right {
            let newRoot = root.val < right.val ? root.val : right.val
//            print(newRoot)
            rightTreeNode = TreeNode(newRoot, TreeNode(root.val), right.right)
        }
        
        return isLeft(leftTreeNode) && isRight(rightTreeNode)
    }

    static func isRight(_ root: TreeNode?) -> Bool {
        guard let root = root else {
            return true
        }

        if let right = root.right?.val,
           right <= root.val {
//            print("here1")
            return false
        }
        
        var leftTreeNode: TreeNode? = root.left
        var rightTreeNode: TreeNode? = root.right
        if let left = root.left {
            let newRoot = root.val > left.val ? root.val : left.val
            leftTreeNode = TreeNode(newRoot, left.left, TreeNode(root.val))
        }

        if let right = root.right {
            let newRoot = root.val < right.val ? root.val : right.val
//            print(newRoot)
            rightTreeNode = TreeNode(newRoot, TreeNode(root.val), right.right)
        }
        
        return isLeft(leftTreeNode) && isRight(rightTreeNode)
    }
    
    
    
    
    
    
    
    
    
    static func isValidBSTOld(_ root: TreeNode?) -> Bool {
        guard let root = root else {
            return true
        }
        
        if let left = root.left?.val,
           left >= root.val {
//            print("here0")
            return false
        }

        if let right = root.right?.val,
           right <= root.val {
//            print("here1")
            return false
        }

        var leftTreeNode: TreeNode? = root.left
        var rightTreeNode: TreeNode? = root.right
        if let left = root.left {
            let newRoot = root.val > left.val ? root.val : left.val
            leftTreeNode = TreeNode(newRoot, left.left, left.right)
        }

        if let right = root.right {
            let newRoot = root.val < right.val ? root.val : right.val
            print(newRoot)
            rightTreeNode = TreeNode(newRoot, right.left, right.right)
        }
        return validLeftBST(leftTreeNode) && validRightBST(rightTreeNode)
        
        
        
//        var lowestVal = root
//        while leftMost?.left != nil {
//            leftMost = leftMost?.left
//        }
        
    }
    
    static func validRightBST(_ root: TreeNode?) -> Bool {
//        print("validRightBST")
        guard let root = root else {
            return true
        }
        
        if let left = root.left?.val,
           left <= root.val {
            return false
        }

        if let right = root.right?.val,
           right >= root.val {
//            print("right \(right) root \(root.val)")
            return false
        }

        
        var leftTreeNode: TreeNode? = root.left
        var rightTreeNode: TreeNode? = root.right
        if let left = root.left {
            let newRoot = root.val > left.val ? root.val : left.val
            leftTreeNode = TreeNode(newRoot, left.left, left.right)
        }

        if let right = root.right {
            let newRoot = root.val < right.val ? root.val : right.val
            rightTreeNode = TreeNode(newRoot, right.left, right.right)
        }
        return validLeftBST(leftTreeNode) && validRightBST(rightTreeNode)
    }
    
    static func validLeftBST(_ root: TreeNode?) -> Bool {
//        print("validLeftBST")
        guard let root = root else {
            return true
        }
        
        if let left = root.left?.val,
           left >= root.val {
            return false
        }

        if let right = root.right?.val,
           right <= root.val {
            print("right \(right) root \(root.val)")
            return false
        }

        
        var leftTreeNode: TreeNode? = root.left
        var rightTreeNode: TreeNode? = root.right
        if let left = root.left {
            let newRoot = root.val > left.val ? root.val : left.val
            leftTreeNode = TreeNode(newRoot, left.left, left.right)
        }

        if let right = root.right {
            let newRoot = root.val < right.val ? root.val : right.val
            rightTreeNode = TreeNode(newRoot, right.left, right.right)
        }
        return validLeftBST(leftTreeNode) && validRightBST(rightTreeNode)
    }
}


//print(Solution.isValidBST(TreeNode(2, TreeNode(1), TreeNode(3)))) // true
//print(Solution.isValidBST(TreeNode(2, TreeNode(2), TreeNode(2)))) // false
//
//print(Solution.isValidBST(TreeNode(5, TreeNode(4), TreeNode(6, TreeNode(3), TreeNode(7))))) // false
//
////[3,1,5,0,2,4,6]
//print(Solution.isValidBST(TreeNode(3, TreeNode(1, TreeNode(0), TreeNode(2)), TreeNode(5, TreeNode(4), TreeNode(6))))) // true


//[32,26,47,19,null,null,56,null,27]
print(Solution.isValidBST(TreeNode(32, TreeNode(26, TreeNode(19, nil, TreeNode(27)), nil), TreeNode(47, nil, TreeNode(56))))) //true
