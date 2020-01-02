//
//  RestAPIBase.swift
//  Schibsted
//
//  Created by Odet Alexandre on 02/01/2020.
//  Copyright © 2020 Odet Alexandre. All rights reserved.
//

import Foundation
import Alamofire

class RestAPIBase: Cancellable {
    var currentRequest: Alamofire.Request?
    
    func cancel() {
        currentRequest?.cancel()
    }
}
