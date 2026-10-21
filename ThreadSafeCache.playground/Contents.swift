import Foundation

struct Ad: Equatable, Hashable {
    static func == (lhs: Ad, rhs: Ad) -> Bool {
        lhs.val == rhs.val
    }
    
    let val: String
    
    public init(_ val: String) {
        self.val = val
    }
}

final class AdNode {
    static func == (lhs: AdNode, rhs: AdNode) -> Bool {
        lhs.val.val == rhs.val.val
    }
    
    let val: Ad
    var nextAd: AdNode?
    weak var previousAd: AdNode?
    
    public init(_ val: Ad) {
        self.val = val
        self.nextAd = nil
        self.previousAd = nil
    }
    
    public init(_ val: Ad, _ nextAd: AdNode?) {
        self.val = val
        self.nextAd = nextAd
        self.previousAd = nil
    }
}


actor AdCache {
    
    private var map = [Ad: AdNode]()
    private var root: AdNode?
    private let capacity = 5
    private var tail: AdNode?
    
    func get(_ ad: Ad) -> Ad? {
        guard let root, let node = map[ad] else { return nil }
        
        //if node is already root we dont need to update the cache
        if node == root { return node.val }
        
        //update the root with latest
        let newRoot = node
        node.previousAd?.nextAd = node.nextAd
        node.nextAd?.previousAd = node.previousAd
        self.root?.previousAd = newRoot
        self.root = newRoot
        
        return node.val
    }
    
    func getMostRecent() -> Ad? {
        guard let root else { return nil }
        
        return root.val
    }
    
    func put(_ ad: Ad) {
        if root == nil {
            root = AdNode(ad)
            tail = root
            map[ad] = root
        } else if let node = map[ad]  {
            //update the root with latest
            if let tail, tail == node {
                self.tail = node.previousAd
            }
            let newRoot = node
            node.previousAd?.nextAd = node.nextAd
            node.nextAd?.previousAd = node.previousAd
            self.root?.previousAd = newRoot
            self.root = newRoot
        } else {
            //add the new node as the root update Cache
            let newNode = AdNode(ad, root)
            root?.previousAd = newNode
            root = newNode
            map[ad] = newNode
            
            rebalance()
   
        }
    }
    
    private func rebalance() {
        if map.count > capacity {
            // remove tail
            print("removing")
            if let previous = tail?.previousAd {
                
                if let tail {
                    map.removeValue(forKey: tail.val)
                }
                tail = nil
                tail = previous
                tail?.nextAd = nil
            }
        }
    }
}


Task {
    let cache = AdCache()
    let result = await cache.get(Ad("1"))
    print(result?.val)
    
    await cache.put(Ad("3"))
    await cache.put(Ad("5"))
    let result2 = await cache.get(Ad("3"))
    let result3 = await cache.get(Ad("5"))
    print(result2?.val)
    print(result3?.val)
}
