import Foundation

func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
    var tops: [Int] = []
    var frequencies = [Int: Int]()
    
    nums.forEach { num in
        if frequencies[num] == nil {
            frequencies[num] = 1
        } else {
            frequencies[num] = (frequencies[num] ?? 0) + 1
        }
    }
    
    let sorted = frequencies.sorted { $0.value > $1.value }
    
    for frequencies in sorted {
        tops.append(frequencies.value)
        if tops.count == k {
            return tops
        }
    }
    
    
    return tops
}

print(topKFrequent([5,4,3,5,2,3,3,3,3,7,9], 1)) //3
print(topKFrequent([5,4,3,5,2,3,3,3,3,7,5], 2)) //3, 5
