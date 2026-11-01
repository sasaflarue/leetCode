import Foundation

actor SimpleTaskGroup {
    let maxConcurrentTasks: Int
    private var tasks = [() -> Void]()
    
    
    public init(maxConcurrentTasks: Int) {
        self.maxConcurrentTasks = maxConcurrentTasks
    }
    
    func addTask(_ tasks: [() async -> Void]) async {
        var taskIterator = tasks.makeIterator()
        
        await withTaskGroup { group in
            for task in 0..<maxConcurrentTasks {
                if let task = taskIterator.next() {
                    group.addTask { await task() }
                }
            }
                
                for await data in group {
                    if let task = taskIterator.next() {
                        group.addTask { await task() }
                    }
                }
        }
    }
}
