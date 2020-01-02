//
//  Team.swift
//  Schibsted
//
//  Created by Odet Alexandre on 02/01/2020.
//  Copyright © 2020 Odet Alexandre. All rights reserved.
//

import Foundation

class Team: Codable {
    var id: Int
    var name: String
    var logoUrl: String
    var isWinner: Bool
}

/*
 "id": "22984",
 "name": "Stabæk",
 "logoUrl": "https://cdn-yams.schibsted.com/api/v1/sports-pro/images/d0/d040451e-176c-4c83-a2ea-37667dfc0e7f",
 "isWinner": false*/
