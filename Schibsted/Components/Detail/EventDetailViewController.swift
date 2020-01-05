//
//  EventDetailViewController.swift
//  Schibsted
//
//  Created by Odet Alexandre on 03/01/2020.
//  Copyright © 2020 Odet Alexandre. All rights reserved.
//

import Foundation
import UIKit
import Combine
import SwiftOverlays

class EventDetailViewController: UIViewController, Reachable {
    var eventId: Int!
    
    //Combine+Network
    private let restApiEvent = RestAPIEvent()
    private var cancellableSet = Set<AnyCancellable>()
    
    @IBOutlet weak var eventDateLabel: UILabel!
    
    @IBOutlet weak var homeTeamLogo: UIImageView!
    @IBOutlet weak var homeTeamScoreLabel: UILabel!
    @IBOutlet weak var homeTeamNameLabel: UILabel!
    
    @IBOutlet weak var awayTeamLogo: UIImageView!
    @IBOutlet weak var awayTeamScoreLabel: UILabel!
    @IBOutlet weak var awayTeamNameLabel: UILabel!
    
    @IBOutlet weak var eventVenueLabel: UILabel!
    @IBOutlet weak var finalOrDashLabel: UILabel!
    
    deinit { //Cancel request when controller is deinit
        restApiEvent.cancel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        showWaitOverlayWithText("Loading details...")
        restApiEvent.getEvent(with: eventId)
            .subscribe(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                self.removeAllOverlays()
                switch completion {
                case .finished:
                break //Everything is OK.
                case .failure(let error):
                    if error is NetworkError {
                        self.alertWhenNetworkNotAvailable() //We have no network
                    } else {
                        self.displayAlertOnError() //Server error
                    }
                }
            }, receiveValue: { detail in
                
                self.eventDateLabel.text = Date.schedulePretty(fromIsoDate: detail.event.startDate)
                
                self.homeTeamLogo.setImage(fromUrl: detail.event.homeTeam.logoUrl, withSize: .medium)
                self.homeTeamScoreLabel.text = "\(detail.event.result.runningScore.home)"
                self.homeTeamNameLabel.text = detail.event.homeTeam.name
                self.homeTeamNameLabel.adjustsFontSizeToFitWidth = true
                
                self.awayTeamLogo.setImage(fromUrl: detail.event.awayTeam.logoUrl, withSize: .medium)
                self.awayTeamScoreLabel.text = "\(detail.event.result.runningScore.away)"
                self.awayTeamNameLabel.text = detail.event.awayTeam.name
                self.awayTeamNameLabel.adjustsFontSizeToFitWidth = true
                
                if let venue = detail.event.venue {
                    self.eventVenueLabel.text = "Event at \(venue.name) in \(venue.city)"
                }
                
                let status = EventStatus(with: detail.event.status.type)
                if status == .inProgress {
                    self.awayTeamScoreLabel.textColor = .systemGreen
                    self.homeTeamScoreLabel.textColor = .systemGreen
                } else if status == .finished {
                    self.finalOrDashLabel.text = "FINAL"
                }
            })
        .store(in: &cancellableSet)
    }
    
    @IBAction func didClickCloseButton() {
        dismiss(animated: true, completion: nil)
    }
    
}
