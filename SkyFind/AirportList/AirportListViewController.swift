//
//  AirportListViewController.swift
//  SkyFind
//
//  Created by Angie Mugo on 11/06/2019.
//  Copyright © 2019 Angie Mugo. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

protocol AiportListViewDelegate {
    func getAirport(_ airport: String)
}

class AirportListViewController: UIViewController, UISearchResultsUpdating {
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

    var searchController = UISearchController()
    var delegate: AiportListViewDelegate?
    let refreshControl = UIRefreshControl()
    var selectedCell: Int?
    var selectedAirport: String?
    var airports = [Airport]()
    var filteredAirports = [Airport]()
    var viewModel: AirportListViewModel? {
        didSet {
            setupViewModel()
        }
    }
    let disposeBag = DisposeBag()

    struct Constants {
        static var AIRPORT_CELL = "airports"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
        searchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()

            mainTableview.tableHeaderView = controller.searchBar

            return controller
        })()
        self.navigationItem.title = "Airports"
        mainTableview.register(AirportListCell.self, forCellReuseIdentifier: Constants.AIRPORT_CELL)
        mainTableview.tableFooterView = UIView()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "leftArrow"), style: .plain, target: self, action: #selector(back))
        viewModel = AirportListViewModel(with: NetworkManager(),
                                         refreshControl: refreshControl.rx.controlEvent(.valueChanged).asDriver())
    }

    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }

    func filterContentForSearchText(_ searchText: String) {
        filteredAirports = airports.filter({(airport: Airport) -> Bool in
            return airport.airportCode.lowercased().contains(searchText.lowercased())
        })

        mainTableview.reloadData()
    }

    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
}
