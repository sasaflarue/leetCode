//
//  EventListViewModel.swift
//  PracticeInterview
//
//  Created by Alexander LaRue on 10/31/25.
//

import Foundation

@MainActor
final class EventListViewModel: ObservableObject {
    // Exposed to VC
    private(set) var items: [Event] = []
    private(set) var isInitialLoading = false
    private(set) var isPaging = false
    private(set) var errorMessage: String? = nil
    var filters = FilterState() { didSet { onFiltersChanged() } }

    private let service: EventService
    private var nextPageToken: String?
    private var allIDs = Set<String>()
    private var debounceTask: Task<Void, Never>?

    init(service: EventService) { self.service = service }

    func loadInitial() {
        Task { await fetch(reset: true) }
    }

    func refresh() {
        Task { await fetch(reset: true) }
    }

    func loadNextPageIfNeeded(visibleIndex: Int) {
        guard !isPaging, visibleIndex >= items.count - 5, nextPageToken != nil else { return }
        Task { await fetch(reset: false) }
    }

    private func onFiltersChanged() {
        debounceTask?.cancel()
        debounceTask = Task { [weak self] in
            try? await Task.sleep(nanoseconds: 350_000_000) // 350ms
            await self?.fetch(reset: true)
        }
    }

    private func makeQuery() -> Query {
        Query(
            category: filters.category,
            city: filters.cityQuery,
            dateRange: filters.dateRange,
            maxPrice: filters.maxPrice,
            sort: filters.sort,
            pageSize: 25
        )
    }

    private func fetch(reset: Bool) async {
        if reset {
            isInitialLoading = true
            nextPageToken = nil
            allIDs.removeAll()
        } else {
            guard nextPageToken != nil else { return }
            isPaging = true
        }

        do {
            let page = try await service.fetchPage(query: makeQuery(), pageToken: nextPageToken)
            nextPageToken = page.nextPageToken

            var new = reset ? [] : items
            for e in page.items where !allIDs.contains(e.id) {
                new.append(e)
                allIDs.insert(e.id)
            }
            items = new
            errorMessage = nil
        } catch {
            errorMessage = (error as NSError).localizedDescription
        }
        isInitialLoading = false
        isPaging = false
    }
}
