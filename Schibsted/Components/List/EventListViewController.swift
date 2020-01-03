//
//  ViewController.swift
//  Schibsted
//
//  Created by Odet Alexandre on 02/01/2020.
//  Copyright © 2020 Odet Alexandre. All rights reserved.
//

import UIKit
import Combine
import SwiftOverlays

class EventListViewController: UIViewController, Reachable {
    
    //TableView
    @IBOutlet weak var leaguesTableView: UITableView!
    private lazy var dataSource = setUpDataSource()
    private let cellEventIdentifier = "eventCell"
    private let headerViewIdentifier = "eventHeaderView"
    private let refreshControl = UIRefreshControl()
    
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
        
        let nib = UINib(nibName: "EventTableViewHeaderView", bundle: nil)
        
        leaguesTableView.register(nib, forHeaderFooterViewReuseIdentifier: headerViewIdentifier)
        leaguesTableView.delegate = self
        leaguesTableView.dataSource = dataSource
        
        refreshControl.addTarget(self, action: #selector(fetchData), for: .valueChanged)
        
        if #available(iOS 10.0, *) {
            leaguesTableView.refreshControl = refreshControl
        } else {
            leaguesTableView.addSubview(refreshControl)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchData()
    }
    
    @objc func fetchData() {
        showWaitOverlayWithText("Loading...")
        restAPIEvent.getEventsList()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: {
                completion in
                switch completion {
                case .finished:
                    self.removeAllOverlays()
                    self.refreshControl.endRefreshing()
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
        let sectionIdentifiers: [Int] = Array(0...leagues.count-1)
        snapshot.appendSections(sectionIdentifiers)
        for i in 0..<leagues.count {
            snapshot.appendItems(leagues[i].events, toSection: i)
        }
        dataSource.apply(snapshot, animatingDifferences: false)
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
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerViewIdentifier) as! EventTableViewHeaderView
        let currentLeague = leagues[section]
        headerView.build(with: currentLeague)

        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
}

