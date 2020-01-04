//
//  UIViewControllerExtension.swift
//  Schibsted
//
//  Created by Odet Alexandre on 04/01/2020.
//  Copyright © 2020 Odet Alexandre. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func displayAlertOnError() {
        let alert = UIAlertController(title: "Oops", message: "It seems that something went wrong.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
