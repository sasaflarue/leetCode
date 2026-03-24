//
//  FilterState.swift
//  PracticeInterview
//
//  Created by Alexander LaRue on 10/31/25.
//

import Foundation

struct FilterState: Equatable {
    var category: EventCategory? = nil
    var cityQuery: String = ""
    var dateRange: ClosedRange<Date>? = nil
    var maxPrice: Decimal? = nil
    var sort: Query.Sort = .relevance
}
