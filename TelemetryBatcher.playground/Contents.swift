import Foundation

struct Event {
    let occuredAt: TimeInterval
}
enum TelemetryError: Error {
    case networkFailed
}

actor TelemetryBatcher {
    private let maxEventQueue: Int
    private let maxTime: TimeInterval
    private var toSend = [Event]()
    private var sendTask: Task<Void, Never>? = nil
    
    public init(maxEventQueue: Int = 10, maxTime: TimeInterval = 5.0) {
        self.maxEventQueue = maxEventQueue
        self.maxTime = maxTime
    }
    
    deinit {
        sendTask?.cancel()
    }
    
    public func send(_ event: Event) {
        let currentTime = Date().timeIntervalSince1970
        if toSend.count == 0 {
            toSend.append(event)
            startSendTaskLoop()
        } else if toSend.count >= maxEventQueue - 1 {
            toSend.append(event)
            drain()
        } else if let first = toSend.first {
            //assume events are always immediately sent and occured at can be trusted
            toSend.append(event)
            if first.occuredAt < currentTime - maxTime {
                drain()
            }
        }
    }
    
    private func startSendTaskLoop() {
        sendTask = Task { [weak self] in
            while !Task.isCancelled {
                do {
                    guard let self else { return }
                    try await Task.sleep(nanoseconds: UInt64(1000000000 * self.maxTime))
                    await self.drain()
                } catch {
                    break
                }
            }
            
        }
    }
    
    private func drain() {
        let sending = toSend
        Task { [weak self] in
            guard let self  else { return }
            do {
                if Int.random(in: 0...5) == 3 {
                    throw TelemetryError.networkFailed
                }
            } catch {
                self.toSend = await sending + self.toSend
            }
        }
        
        toSend = [Event]()
        
        
    }
}
