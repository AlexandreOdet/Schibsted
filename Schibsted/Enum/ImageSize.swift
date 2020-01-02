//
//  ImageSize.swift
//  Schibsted
//
//  Created by Odet Alexandre on 02/01/2020.
//  Copyright © 2020 Odet Alexandre. All rights reserved.
//

import Foundation

enum ImageSize {
    case small
    case medium
    case large
    
    var size: Int {
        switch self {
        case .small:
            return 32
        case .medium:
            return 56
        case .large:
            return 112
        }
    }
}
