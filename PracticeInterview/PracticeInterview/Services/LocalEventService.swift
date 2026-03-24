//
//  LocalEventService.swift
//  PracticeInterview
//
//  Created by Alexander LaRue on 10/31/25.
//

import Foundation

final class LocalEventService: EventService {
    private let all: [Event]
    private let decoder: JSONDecoder = {
        let d = JSONDecoder()
        d.dateDecodingStrategy = .iso8601
        return d
    }()

    init() {
        let url = Bundle.main.url(forResource: "events", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        self.all = try! decoder.decode([Event].self, from: data)
    }

    func fetchPage(query: Query, pageToken: String?) async throws -> Page<Event> {
        let filtered = Self.apply(query: query, to: all)
        let start = Int(pageToken ?? "0") ?? 0
        let end = min(start + query.pageSize, filtered.count)
        let slice = Array(filtered[start..<end])
        let next = end < filtered.count ? String(end) : nil
        return Page(items: slice, nextPageToken: next, updatedIDs: nil)
    }

    private static func apply(query: Query, to input: [Event]) -> [Event] {
        var out = input
        if let cat = query.category {
            out = out.filter { $0.category == cat }
        }
        if !query.city.isEmpty {
            let q = query.city.lowercased()
            out = out.filter { $0.venue.city.lowercased().contains(q) }
        }
        if let range = query.dateRange {
            out = out.filter { range.contains($0.datetimeLocal) }
        }
        if let cap = query.maxPrice {
            out = out.filter { ($0.pricing.min as NSDecimalNumber).doubleValue <= (cap as NSDecimalNumber).doubleValue }
        }
        switch query.sort {
        case .relevance: break
        case .date: out.sort { $0.datetimeLocal < $1.datetimeLocal }
        case .price:
            out.sort {
                ($0.pricing.min as NSDecimalNumber).doubleValue
                < ($1.pricing.min as NSDecimalNumber).doubleValue
            }
        case .popularity: out.sort { $0.popularity > $1.popularity }
        }
        return out
    }
}
