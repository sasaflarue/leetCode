//
//  RemoteEventService.swift
//  PracticeInterview
//
//  Created by Alexander LaRue on 10/31/25.
//

import Foundation

final class RemoteEventService: EventService {
    private let local = LocalEventService()

    func fetchPage(query: Query, pageToken: String?) async throws -> Page<Event> {
        try await Task.sleep(nanoseconds: UInt64(Int.random(in: 600...1200)) * 1_000_000) // 600–1200ms
        if Int.random(in: 0..<100) < 12 { throw URLError(.cannotConnectToHost) } // ~12% fail
        // Simulate small updates between pages (e.g., popularity jitter)
        var page = try await local.fetchPage(query: query, pageToken: pageToken)
        if Bool.random() {
            let ids = Set(page.items.prefix(3).map { $0.id })
            page = Page(items: page.items, nextPageToken: page.nextPageToken, updatedIDs: ids)
        }
        return page
    }
}

