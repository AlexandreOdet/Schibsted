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
    
    @IBOutlet weak var finalOrDateLabel: UILabel!
    
    let boldFont = UIFont.boldSystemFont(ofSize: 16.0)
    
    func build(with event: Event) {
        
        let homeScore = event.result.runningScore.home
        let awayScore = event.result.runningScore.away
        
        homeTeamScoreLabel.text = "\(homeScore)"
        awayTeamScoreLabel.text = "\(awayScore)"
        
        homeTeamNameLabel.text = event.homeTeam.name
        awayTeamNameLabel.text = event.awayTeam.name
        
        homeTeamLogoImg.setImageFromUrl(url: event.homeTeam.logoUrl, withSize: .small)
        awayTeamLogoImg.setImageFromUrl(url: event.awayTeam.logoUrl, withSize: .small)
        
        if homeScore != awayScore {
            if homeScore > awayScore {
                homeTeamScoreLabel.font = boldFont
                homeTeamNameLabel.font = boldFont
            } else {
                awayTeamNameLabel.font = boldFont
                awayTeamScoreLabel.font = boldFont
            }
        }
        
        let status = EventStatus(with: event.status.type)
        if status != .finished {
            finalOrDateLabel.adjustsFontSizeToFitWidth = true
            finalOrDateLabel.text = Date.schedulePretty(fromIsoDate: event.startDate)
            
            if status == .inProgress {
                finalOrDateLabel.textColor = .systemGreen
            }
        }
    }
}
