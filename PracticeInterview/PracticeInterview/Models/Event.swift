//
//  Event.swift
//  PracticeInterview
//
//  Created by Alexander LaRue on 10/31/25.
//

import Foundation

struct Event: Identifiable, Hashable, Decodable {
    let id: String
    let name: String
    let category: EventCategory
    let datetimeLocal: Date
    let venue: Venue
    let performers: [Performer]
    let images: Images
    let pricing: Money
    let popularity: Double
    let flags: Flags
}
