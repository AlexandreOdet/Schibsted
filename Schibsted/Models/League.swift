//
//  League.swift
//  Schibsted
//
//  Created by Odet Alexandre on 02/01/2020.
//  Copyright © 2020 Odet Alexandre. All rights reserved.
//

import Foundation

class League: Codable {
    var id: Int
    var logoUrl: String
    var events: [Event]
}

/*
 "id": 38,
    "name": "Eliteserien",
    "logoUrl": "https://cdn-yams.schibsted.com/api/v1/sports-pro/images/3e/3e371e7a-988b-478a-b517-ba8d84f921a3",
    "events": [
      {
        "id": 377462,
        "startDate": "2019-08-31T16:00:00Z",
        "homeTeam": {
          "id": "22984",
          "name": "Stabæk",
          "logoUrl": "https://cdn-yams.schibsted.com/api/v1/sports-pro/images/d0/d040451e-176c-4c83-a2ea-37667dfc0e7f",
          "isWinner": false
        },
        "awayTeam": {
          "id": "22981",
          "name": "Strømsgodset",
          "logoUrl": "https://cdn-yams.schibsted.com/api/v1/sports-pro/images/fe/fe5e69cb-0627-477f-bbb1-20e19d174a1d",
          "isWinner": false
        },
        "result": {
          "runningScore": {
            "home": 0,
            "away": 0
          }
        },
        "status": {
          "type": "notStarted"
        }
      }
 */
