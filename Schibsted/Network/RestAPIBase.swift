//
//  RestAPIBase.swift
//  Schibsted
//
//  Created by Odet Alexandre on 02/01/2020.
//  Copyright © 2020 Odet Alexandre. All rights reserved.
//

import Foundation
import Alamofire

class RestAPIBase: Cancellable, Reachable {
    var currentRequest: Alamofire.Request?
    
    let baseUrl = "https://sports-app-code-test.herokuapp.com/api/events"
    
    func cancel() {
        currentRequest?.cancel()
    }
}
