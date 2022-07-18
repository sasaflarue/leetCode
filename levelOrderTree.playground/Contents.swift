//Given the root of a binary tree, return the level order traversal of its nodes' values. (i.e., from left to right, level by level).

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
    static func levelOrder(_ root: TreeNode?) -> [[Int]] {
        var arr = [[Int]]()
        if root?.left == nil && root?.right == nil,
        let root = root {
            return [[root.val]]
        } else if let root = root {
            arr.append([root.val])
            
            let left = levelOrder(root.left)
            let right = levelOrder(root.right)
            var combined = [[Int]]()
            if left.count > right.count {
                for (index, item) in left.enumerated() {
                    
                    let levelVals = item + (right.count > index ? right[index] : [Int]())
                    combined.append(contentsOf: [levelVals])
                }
                arr.append(contentsOf: combined)
            } else {
                for (index, item) in right.enumerated() {
                    
                    let levelVals = (left.count > index ? left[index] : [Int]()) + item
                    combined.append(contentsOf: [levelVals])
                }
                arr.append(contentsOf: combined)
            }
        }
        
        return arr
    }
}

print(Solution.levelOrder(TreeNode(1)))

print(Solution.levelOrder(TreeNode(1, TreeNode(2), TreeNode(2, TreeNode(3, TreeNode(4), nil), TreeNode(3)))))

