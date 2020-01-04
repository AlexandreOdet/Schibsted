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
    
    func getEvents() -> AnyPublisher<[League], Error> {
        var future: Future<[League], Error> { return Future { promise in
            if !self.isNetworkAvailable {
                promise(.failure(NetworkError.unreachable))
            }
            AF.request(self.baseUrl, parameters: ["date":"today"])
                .validate(statusCode: 200..<300)
                .responseDecodable(completionHandler: { (response: DataResponse<[League], AFError>) in
                    guard response.error == nil else {
                        print("Error on league fetching: \(String(describing: response.error))")
                        promise(.failure(response.error!))
                        return
                    }
                    do {
                        let array = try response.result.get()
                        promise(.success(array))
                    } catch {
                        promise(.failure(error))
                    }
                })
            }
        }
        return future.catch { error in Fail(error: error) }.eraseToAnyPublisher()
    }
    
    func getEvent(with id: Int) -> AnyPublisher<Detail, Error> {
        var future: Future<Detail, Error> { return Future { promise in
            if !self.isNetworkAvailable {
                promise(.failure(NetworkError.unreachable))
            }
            let finalUrl = self.baseUrl + "/\(id)"
            AF.request(finalUrl)
                .validate(statusCode: 200..<300)
                .responseDecodable(completionHandler: { (response: DataResponse<Detail, AFError>) in
                    guard response.error == nil else {
                        print("Error on event fetching: \(String(describing: response.error))")
                        promise(.failure(response.error!))
                        return
                    }
                    do {
                        let event = try response.result.get()
                        promise(.success(event))
                    } catch {
                        promise(.failure(error))
                    }
                })
            }
        }
        return future.catch { error in Fail(error: error) }.eraseToAnyPublisher()
    }
}

