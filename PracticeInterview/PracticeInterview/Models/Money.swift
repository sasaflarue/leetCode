//
//  Money.swift
//  PracticeInterview
//
//  Created by Alexander LaRue on 10/31/25.
//

import Foundation

struct Money: Decodable, Hashable {
    let min: Decimal
    let currency: String
}
