//
//  EventListTableViewCell.swift
//  Schibsted
//
//  Created by Odet Alexandre on 03/01/2020.
//  Copyright © 2020 Odet Alexandre. All rights reserved.
//

import Foundation
import UIKit

class EventListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var homeTeamScoreLabel: UILabel!
    @IBOutlet weak var homeTeamNameLabel: UILabel!
    @IBOutlet weak var homeTeamLogoImg: UIImageView!
    
    @IBOutlet weak var awayTeamScoreLabel: UILabel!
    @IBOutlet weak var awayTeamNameLabel: UILabel!
    @IBOutlet weak var awayTeamLogoImg: UIImageView!
    
    func build(with event: Event) {
        homeTeamScoreLabel.text = "\(event.result.runningScore.home)"
        awayTeamScoreLabel.text = "\(event.result.runningScore.away)"
        
        homeTeamNameLabel.text = event.homeTeam.name
        awayTeamNameLabel.text = event.awayTeam.name
    }
}
