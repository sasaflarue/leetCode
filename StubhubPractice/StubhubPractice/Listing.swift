//
//  Listing.swift
//  StubhubPractice
//
//  Created by Alexander LaRue on 11/4/25.
//

import Foundation

// MARK: - Model

struct Listing: Codable, Equatable, Hashable {
    let id: String
    let eventName: String?
    let homeTeam: String?
    let awayTeam: String?
    let venue: String
    let price: Double
    let currency: String
    let eventDate: Date
    let section: String?
    let row: String?

    // Precomputed normalization to speed up filtering/search
    var lcEventName: String { eventName?.lowercased() ?? "" }
    var lcVenue: String { venue.lowercased() }
    var teams: [String] { [homeTeam, awayTeam].compactMap{ $0 ?? "" }}
}

// MARK: - Sorting

enum SortKey {
    case priceAsc
    case dateAsc

    func sorter(_ a: Listing, _ b: Listing) -> Bool {
        switch self {
        case .priceAsc: return a.price < b.price
        case .dateAsc:  return a.eventDate < b.eventDate
        }
    }
}

func sortBy(listings: [Listing], _ key: SortKey) -> [Listing] {
    return listings.sorted(by: key.sorter(_:_:))
}

// MARK: - Filter system (composable)

protocol Filter {
    associatedtype T
    func matches(_ value: T) -> Bool
}

struct AnyFilter<T>: Filter {
    private let _matches: (T) -> Bool
    init(_ f: @escaping (T) -> Bool) { _matches = f }
    func matches(_ value: T) -> Bool { _matches(value) }

    func and(_ other: AnyFilter<T>) -> AnyFilter<T> {
        AnyFilter { self.matches($0) && other.matches($0) }
    }
    
    func or(_ other: AnyFilter<T>) -> AnyFilter<T> {
        AnyFilter { self.matches($0) || other.matches($0) }
    }
}

// Common filters
struct TeamFilter: Filter {
    typealias T = Listing
    let needle: String // already lowercased
    func matches(_ v: Listing) -> Bool {
        v.teams.contains { $0.lowercased().contains(needle) }
    }
}

struct PriceRangeFilter: Filter {
    typealias T = Listing
    let min: Double?
    let max: Double?
    func matches(_ v: Listing) -> Bool {
        if let min, v.price < min { return false }
        if let max, v.price > max { return false }
        return true
    }
}

struct DateRangeFilter: Filter {
    typealias T = Listing
    let start: Date?
    let end: Date?
    func matches(_ v: Listing) -> Bool {
        if let start, v.eventDate < start { return false }
        if let end, v.eventDate > end { return false }
        return true
    }
}

struct SectionFilter: Filter {
    typealias T = Listing
    let needle: String // lowercased
    func matches(_ v: Listing) -> Bool {
        guard let s = v.section?.lowercased() else { return false }
        return s.contains(needle)
    }
}

struct TextSearchFilter: Filter {
    typealias T = Listing
    let needle: String // lowercased
    func matches(_ v: Listing) -> Bool {
        let matcher = needle.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        return v.lcEventName.trimmingCharacters(in: .whitespacesAndNewlines).contains(matcher) || v.lcVenue.trimmingCharacters(in: .whitespacesAndNewlines).contains(matcher)
    }
}

struct VenueFilter: Filter {
    typealias T = Listing
    let needle: String
    func matches(_ v: Listing) -> Bool {
        v.venue.contains(needle)
    }
}


// MARK: - Query

struct Query {
    var sort: SortKey = .priceAsc
    var filters: [AnyFilter<Listing>] = []

    func predicate() -> AnyFilter<Listing> {
        filters.reduce(AnyFilter { _ in true }) { $0.and($1) }
    }
}

// MARK: - Data sources

protocol RemoteDataSource {
    func fetch() async throws -> [Listing]
}

protocol CacheDataSource {
    func read() throws -> CachedPayload?
    func write(_ payload: CachedPayload) throws
    func clear() throws
}

struct CachedPayload: Codable {
    let fetchedAt: Date
    let listings: [Listing]
    
    func isStale(ttlSeconds: TimeInterval, now: Date = Date()) -> Bool {
            now.timeIntervalSince(fetchedAt) > ttlSeconds
        }
}

// Simple disk cache via JSON
final class DiskCache: CacheDataSource {
    private let url: URL
    init(filename: String = "listings-cache.json") {
        let dir = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        self.url = dir.appendingPathComponent(filename)
    }

    func read() throws -> CachedPayload? {
        guard FileManager.default.fileExists(atPath: url.path) else { return nil }
        let data = try Data(contentsOf: url)
        let dec = JSONDecoder()
        dec.dateDecodingStrategy = .iso8601
        return try dec.decode(CachedPayload.self, from: data)
    }

    func write(_ payload: CachedPayload) throws {
        let enc = JSONEncoder()
        enc.outputFormatting = [.prettyPrinted]
        enc.dateEncodingStrategy = .iso8601
        let data = try enc.encode(payload)
        try data.write(to: url, options: .atomic)
    }

    func clear() throws {
        if FileManager.default.fileExists(atPath: url.path) {
            try FileManager.default.removeItem(at: url)
        }
    }
}

// MARK: - Repository

struct LoadResult {
    let items: [Listing]
    let fromCache: Bool
    let isStale: Bool
}

protocol ListingsRepository {
    func load(query: Query, ttlSeconds: TimeInterval) async -> LoadResult
}

final class DefaultListingsRepository: ListingsRepository {
    private let remote: RemoteDataSource
    private let cache: CacheDataSource

    init(remote: RemoteDataSource, cache: CacheDataSource) {
        self.remote = remote
        self.cache = cache
    }

    func load(query: Query, ttlSeconds: TimeInterval) async -> LoadResult {
        // 1) Try cache
        if let cached = try? cache.read() {
            let base = cached.listings
            let pred = query.predicate()
            let filtered = base.filter { pred.matches($0) }.sorted(by: query.sort.sorter)
            let stale = cached.isStale(ttlSeconds: ttlSeconds)
            // 2) If stale, try background refresh but still return cached immediately in interview
            if stale {
                Task.detached { [remote, cache] in
                    if let fresh = try? await remote.fetch() {
                        let payload = CachedPayload(fetchedAt: Date(), listings: fresh)
                        try? cache.write(payload)
                    }
                }
            }
            return LoadResult(items: filtered, fromCache: true, isStale: stale)
        }

        // 3) No cache → fetch
        if let fresh = try? await remote.fetch() {
            let payload = CachedPayload(fetchedAt: Date(), listings: fresh)
            try? cache.write(payload)
            let pred = query.predicate()
            let filtered = fresh.filter { pred.matches($0) }.sorted(by: query.sort.sorter)
            return LoadResult(items: filtered, fromCache: false, isStale: false)
        } else {
            // 4) No cache + fetch failed
            return LoadResult(items: [], fromCache: true, isStale: true)
        }
    }
}

// MARK: - Debouncer (for search)

final class Debouncer {
    private var task: Task<Void, Never>?
    func run(after seconds: TimeInterval, _ block: @escaping () -> Void) {
        task?.cancel()
        task = Task {
            try? await Task.sleep(nanoseconds: UInt64(seconds * 1_000_000_000))
            guard !Task.isCancelled else { return }
            block()
        }
    }
}
