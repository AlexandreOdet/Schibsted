//
//  ViewController.swift
//  Schibsted
//
//  Created by Odet Alexandre on 02/01/2020.
//  Copyright © 2020 Odet Alexandre. All rights reserved.
//

import UIKit
import Combine

class EventListViewController: UIViewController {
    
    @IBOutlet weak var leaguesTableView: UITableView!
    
    var leagues = [League]()

    override func viewDidLoad() {
        super.viewDidLoad()
        leaguesTableView.delegate = self
        // Do any additional setup after loading the view.
    }

    private func setUpDataSource() -> UITableViewDiffableDataSource<Int, Event> {
        let dataSource = UITableViewDiffableDataSource<Int, Event>(tableView: leaguesTableView, cellProvider: {
            tableView, indexPath, event in
            return UITableViewCell()
        })
        return dataSource
    }

}

extension EventListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
}
