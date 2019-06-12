//
//  AirportListViewController.swift
//  SkyFind
//
//  Created by Angie Mugo on 11/06/2019.
//  Copyright © 2019 Angie Mugo. All rights reserved.
//

import UIKit

protocol AiportListViewDelegate {
    func getAirport(_ airport: String)
}

class AirportListViewController: UIViewController {

    let mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()

    let mainTableview: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var delegate: AiportListViewDelegate?
    var selectedCell: Int?

    struct Constants {
        static var AIRPORT_CELL = "airports"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Airports"
        mainTableview.register(AirportListCell.self, forCellReuseIdentifier: Constants.AIRPORT_CELL)
        mainTableview.tableFooterView = UIView()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "leftArrow"), style: .plain, target: self, action: #selector(back))
        self.setupUI()
    }
}
