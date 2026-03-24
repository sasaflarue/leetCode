//
//  Query.swift
//  PracticeInterview
//
//  Created by Alexander LaRue on 10/31/25.
//

import Foundation

struct Query: Equatable {
    var category: EventCategory? = nil
    var city: String = ""
    var dateRange: ClosedRange<Date>? = nil
    var maxPrice: Decimal? = nil
    enum Sort { case relevance, date, price, popularity }
    var sort: Sort = .relevance
    var pageSize: Int = 25
}
