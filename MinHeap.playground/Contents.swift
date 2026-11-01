import Foundation


class MinHeap {
    var heap = [Int]()
    
    func peak() -> Int? {
        return heap.first
    }
    
    func push(_ value: Int) {
        heap.append(value)
        if heap.count > 1 {
            var index = heap.count - 1
            var parent = (index - 1 ) / 2
            while parent >= 0 && heap[parent] > value  {
                heap[index] = heap[parent]
                heap[parent] = value
                
                index = parent
                parent = (index - 1 ) / 2
            }
        }
    }
    
    func pop() -> Int? {
        
        if let minValue = heap.first {
            if heap.count > 1,
               let last = heap.popLast() {
                
                var index = 0
                heap[index] = last
                while index < heap.count {
                    var leftChild = 2 * index + 1
                    var rightChild = 2 * index + 2
                    var smallest = index
                    if leftChild < heap.count && heap[leftChild] < heap[index] {
                        smallest = leftChild
                    }
                    
                    if rightChild < heap.count && heap[rightChild] < heap[smallest] {
                        smallest = rightChild
                    }
                    
                    if smallest == index {
                        return minValue
                    }
                    
                    heap.swapAt(smallest, index)
                    index = smallest
                }
                
            } else {
                heap = []
            }
            
            return minValue
        }
        
        return nil
    }
}

var heap = MinHeap()
heap.push(2)
heap.push(5)
heap.push(1)
heap.push(0)
heap.push(-1)
heap.push(10)
print(heap.heap)
heap.pop()
print(heap.heap)
heap.pop()
print(heap.heap)
