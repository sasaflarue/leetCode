import Foundation


actor RateLimitUrlFetch {
    let maxConcurrentFetches: Int
    
    public init(maxConcurrentFetches: Int) {
        self.maxConcurrentFetches = maxConcurrentFetches
    }
    
    public func fetch(_ urls: [URL]) async throws -> [Data] {
        var results = [Data]()
        var urlIterator = urls.makeIterator()
        try await withThrowingTaskGroup { [weak self] group in
            guard let self else { return }
            
            for i in 0..<maxConcurrentFetches {
                if let nextUrl = urlIterator.next() {
                    group.addTask { try await self.fetchData(nextUrl) }
                }
            }
            
            
            for try await data in group {
                results.append(data)
                
                if let nextUrl = urlIterator.next() {
                    group.addTask { try await self.fetchData(nextUrl) }
                }
            }
            
        }
        
        return results
    }
    
    private func fetchData(_ url: URL) async throws -> Data {
        try await URLSession.shared.data(for: URLRequest(url: url)).0
    }
}



