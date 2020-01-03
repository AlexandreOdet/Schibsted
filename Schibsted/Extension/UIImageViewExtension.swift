//
//  UIImageViewExtension.swift
//  Schibsted
//
//  Created by Odet Alexandre on 03/01/2020.
//  Copyright © 2020 Odet Alexandre. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

extension UIImageView {
    func setImageFromUrl(url: String, withSize size: ImageSize) {
        //rule=clip-[dimension]x[dimension]
        let parameters = ["rule":"clip-\(size.size)x\(size.size)"]
        AF.request(url, parameters: parameters)
            .validate()
            .responseData(completionHandler: {
                response in
                do {
                    let imgData = try response.result.get()
                    self.image = UIImage(data: imgData)
                } catch {
                    //Error in fetching data use placeholder image
                }
            })
    }
}
