//
//  DateExtension.swift
//  Schibsted
//
//  Created by Odet Alexandre on 03/01/2020.
//  Copyright © 2020 Odet Alexandre. All rights reserved.
//

import Foundation

extension Date {
    static func schedulePretty(fromIsoDate isoDate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: isoDate)!
        dateFormatter.dateFormat = "HH:mm E"
        return dateFormatter.string(from: date)
    }
}
