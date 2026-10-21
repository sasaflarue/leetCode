import Foundation

class SlidingWindowRateLimiter {
    let limit: Int
    let windowSize: TimeInterval
    // Maps userId to an array of recent request timestamps
    private var clientRequests: [String: [TimeInterval]] = [:]

    init(limit: Int, windowSize: TimeInterval) {
        self.limit = limit
        self.windowSize = windowSize
    }

    func allowRequest(userId: String) -> Bool {
        let currentTime = Date().timeIntervalSince1970
        let windowStart = currentTime - windowSize
        
        if let client = clientRequests[userId] {
            var filtered = client.filter { $0 > windowStart}
            if filtered.count < limit {
                clientRequests[userId] = filtered + [currentTime]
                return true
            } else {
                //depending on if we want to count failed requests against them
                clientRequests[userId] = filtered + [currentTime]
                return false
            }
        } else {
            clientRequests[userId] = [currentTime]
            return true
        }
        
//        if let client = clientRequests[userId] {
//            if client.count >= limit {
//                var clientSorted = client.sorted()
//                if let oldestTime = clientSorted.first,
//                   oldestTime > currentTime - windowSize {
//                    clientSorted.removeFirst()
//                    clientSorted.append(currentTime)
//                    clientRequests[userId] = clientSorted
//                } else{
//                    return false
//                }
//            } else {
//                clientRequests[userId]?.append(currentTime)
//                return true
//            }
//        } else {
//            
//            clientRequests[userId] = [currentTime]
//            return true
//        }
    }
}

let limiter = SlidingWindowRateLimiter(limit: 3, windowSize: 5.0)
let user = "user_123"

print(limiter.allowRequest(userId: user)) // true
print(limiter.allowRequest(userId: user)) // true
print(limiter.allowRequest(userId: user)) // true
print(limiter.allowRequest(userId: user)) // false (exceeded limit)
