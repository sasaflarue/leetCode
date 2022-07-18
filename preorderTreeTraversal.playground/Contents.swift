//Given the root of an n-ary tree, return the preorder traversal of its nodes' values.
//
//Nary-Tree input serialization is represented in their level order traversal. Each group of children is separated by the null value (See examples)



public class Node {
    public var val: Int
    public var children: [Node]
    public init(_ val: Int) {
        self.val = val
        self.children = []
    }
    public init(_ val: Int, _ children: [Node]) {
        self.val = val
        self.children = children
    }
}


class Solution {
    static func preorder(_ root: Node?) -> [Int] {
        var arr = [Int]()
//        print(root?.val)
        if root?.children.isEmpty == true,
           let val = root?.val {
//            print(val)
           return [val]
        } else if let root = root {
            arr.append(root.val)
            root.children.forEach {
                arr.append(contentsOf: preorder($0))
            }
        }
        
        return arr
    }
}

//[1,null,3,2,4,null,5,6] // [1,3,5,6,2,4]
//         1
//null           3
//null null    2      4
//           5   6
var root = Node(1, [Node(3, [Node(2, [Node(5), Node(6)]), Node(4)])])
print(Solution.preorder(root))
