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
    
    @IBOutlet weak var homeTeamLogo: UIImageView!
    @IBOutlet weak var homeTeamScoreLabel: UILabel!
    @IBOutlet weak var homeTeamNameLabel: UILabel!
    
    @IBOutlet weak var awayTeamLogo: UIImageView!
    @IBOutlet weak var awayTeamScoreLabel: UILabel!
    @IBOutlet weak var awayTeamNameLabel: UILabel!
    
    
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
                    self.removeAllOverlays()
                    if error is NetworkError {
                        self.alertWhenNetworkNotAvailable() //We have no network
                    } else {
                        self.displayAlertOnError() //Server error
                    }
                }
            }, receiveValue: { detail in
                self.homeTeamLogo.setImageFromUrl(url: detail.event.homeTeam.logoUrl, withSize: .medium)
                self.awayTeamLogo.setImageFromUrl(url: detail.event.awayTeam.logoUrl, withSize: .medium)
                self.awayTeamScoreLabel.text = "\(detail.event.result.runningScore.away)"
                self.homeTeamScoreLabel.text = "\(detail.event.result.runningScore.home)"
                
                let status = EventStatus(with: detail.event.status.type)
                if status == .inProgress {
                    
                }
            })
        .store(in: &cancellableSet)
    }
    
}