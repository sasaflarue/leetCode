//
//  main.swift
//  StubhubPractice
//
//  Created by Alexander LaRue on 11/4/25.
//

import Foundation

//let fileURL = URL(fileURLWithPath: "mockData.json")

guard let fileURL = Bundle.main.url(forResource: "mockData", withExtension: "json") else {
    fatalError("mockData.json not found in bundle")
}

//let currentPath = FileManager.default.currentDirectoryPath
//let fileURL = URL(fileURLWithPath: "\(currentPath)/mockData.json")
let data = try Data(contentsOf: fileURL)
let decoder = JSONDecoder()
decoder.dateDecodingStrategy = .iso8601
let listings = try decoder.decode([Listing].self, from: data)

print("Total listings: \(listings.count)")
print("Cheapest ticket: \(listings.min(by: { $0.price < $1.price })?.price ?? 0)")

let seattleFilter = AnyFilter(TeamFilter(needle: "seattle".lowercased()).matches)
let priceFilter = AnyFilter(PriceRangeFilter(min: 50, max: 200).matches)

let combined = seattleFilter.and(priceFilter)
let filtered = listings.filter { combined.matches($0) }

print("\nSeattle events under $200:")
for l in filtered {
    print("- \(String(describing: l.eventName)) at \(l.venue) – $\(l.price)")
}


let countByVenue = listings.reduce(into: [String: Int]()) { partialResult, listing in
    let key = listing.lcVenue.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
    if key.isEmpty {
        partialResult["unknown venue", default: 0] += 1
    } else {
        partialResult[key, default: 0] += 1
    }
}.sorted { $0.value > $1.value }

print("\n\nCounts by venue:")
for venue in countByVenue {
    print("\(venue.key): \(venue.value)")
}

print("\nEvents by date:")
sortBy(listings: listings, .dateAsc).forEach{print($0.eventName ?? "unknown event")}

let priceRangeFilter = PriceRangeFilter(min: 5, max: 100)
let eventNameFilter = TextSearchFilter(needle: "SeaTTLE  ")
let combinedFilters = AnyFilter(priceRangeFilter.matches).and(AnyFilter(eventNameFilter.matches))
print(listings.filter {combinedFilters.matches($0)})





