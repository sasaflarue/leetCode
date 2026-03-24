//
//  EventService.swift
//  PracticeInterview
//
//  Created by Alexander LaRue on 10/31/25.
//

import Foundation


protocol EventService {
    func fetchPage(query: Query, pageToken: String?) async throws -> Page<Event>
}
