//
//  ViewController.swift
//  Schibsted
//
//  Created by Odet Alexandre on 02/01/2020.
//  Copyright © 2020 Odet Alexandre. All rights reserved.
//

import UIKit
import Combine

class EventListViewController: UIViewController, Reachable {
    
    //TableView
    @IBOutlet weak var leaguesTableView: UITableView!
    private lazy var dataSource = setUpDataSource()
    private let cellEventIdentifier = "eventCell"
    
    //Combine+Network
    private var cancellableSet = Set<AnyCancellable>()
    let restAPIEvent = RestAPIEvent()
    
    //Data
    var leagues = [League]() {
        didSet {
            self.updateTableView()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        leaguesTableView.delegate = self
        leaguesTableView.dataSource = dataSource
        
        restAPIEvent.getEventsList()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: {
                completion in
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
            }, receiveValue: {
                leagues in
                self.leagues = leagues //update UI
            })
        .store(in: &cancellableSet)
    }

    private func setUpDataSource() -> UITableViewDiffableDataSource<Int, Event> {
        let dataSource = UITableViewDiffableDataSource<Int, Event>(tableView: leaguesTableView, cellProvider: {
            tableView, indexPath, event in
            let cell = tableView.dequeueReusableCell(withIdentifier: self.cellEventIdentifier) as! EventListTableViewCell
            cell.build(with: event)
            return cell
        })
        return dataSource
    }
    
    private func updateTableView() {
        var snapshot =  NSDiffableDataSourceSnapshot<Int, Event>()
        let sectionIdentifiers: [Int] = Array(0...leagues.count)
        snapshot.appendSections(sectionIdentifiers)
        for i in 0..<leagues.count {
            snapshot.appendItems(leagues[i].events, toSection: i)
        }
        dataSource.apply(snapshot)
    }
    
    private func displayAlertOnError() {
        let alert = UIAlertController(title: "Oops", message: "It seems that something went wrong.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }

}

extension EventListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
}

