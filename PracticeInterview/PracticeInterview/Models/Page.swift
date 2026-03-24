//
//  Page.swift
//  PracticeInterview
//
//  Created by Alexander LaRue on 10/31/25.
//

import Foundation

struct Page<T: Hashable>: Hashable {
    let items: [T]
    let nextPageToken: String?
    let updatedIDs: Set<String>? // optional: track updates
}
