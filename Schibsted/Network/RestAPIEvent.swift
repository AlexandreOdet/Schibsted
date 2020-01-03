//
//  RestAPIEvent.swift
//  Schibsted
//
//  Created by Odet Alexandre on 02/01/2020.
//  Copyright © 2020 Odet Alexandre. All rights reserved.
//

import Foundation
import Alamofire
import Combine

final class RestAPIEvent: RestAPIBase {
    
    func getEventsList() {
        let url = "https://sports-app-code-test.herokuapp.com/api/events?date=today"
        AF.request(url)
            .validate(statusCode: 200..<300)
            .responseDecodable(completionHandler: { (response: DataResponse<[League], AFError>) -> Void in
                guard response.error == nil else {
                  print("🥶 Error on league fetching: \(String(describing: response.error))")
                  return
                }
        })
    }
    
    func getEvent(with id: String) {
        
    }
}

