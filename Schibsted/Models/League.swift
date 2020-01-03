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
    var name: String
    var logoUrl: String
    var events: [Event]
}
