//
//  EventStatus.swift
//  Schibsted
//
//  Created by Odet Alexandre on 02/01/2020.
//  Copyright © 2020 Odet Alexandre. All rights reserved.
//

import Foundation

enum EventStatus {
    case inProgress
    case notStarted
    case finished
    
    init(with status: String) {
        switch status {
        case "notStarted":
            self = .notStarted
        case "inProgress":
            self = .inProgress
        case "finished":
            self = .finished
        default:
            self = .notStarted
        }
    }
}
