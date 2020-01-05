//
//  EventTableViewHeaderView.swift
//  Schibsted
//
//  Created by Odet Alexandre on 03/01/2020.
//  Copyright © 2020 Odet Alexandre. All rights reserved.
//

import Foundation
import UIKit

class EventTableViewHeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var leagueNameLabel: UILabel!
    @IBOutlet weak var leagueLogoImg: UIImageView!
    
    func build(with league: League) {
        leagueNameLabel.text = league.name
        leagueLogoImg.setImage(fromUrl: league.logoUrl, withSize: .small)
    }
}
