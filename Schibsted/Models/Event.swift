//
//  Event.swift
//  Schibsted
//
//  Created by Odet Alexandre on 02/01/2020.
//  Copyright © 2020 Odet Alexandre. All rights reserved.
//

import Foundation

class Event: Codable {
    var id: Int
    var startDate: String
    var homeTeam: Team
    var awayTeam: Team
    var result: Result
    var status: Status
    var venue: Venue?
}

extension Event: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func ==(lhs: Event, rhs: Event) -> Bool {
        return lhs.id == rhs.id
    }
}
