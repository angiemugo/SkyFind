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
    func getAirport(_ destination: Airport?, _ origin: Airport?)
}

class AirportListViewController: UIViewController, UISearchResultsUpdating {

    let mainTableview: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var searchController = UISearchController(searchResultsController: nil)
    var delegate: AiportListViewDelegate?
    let refreshControl = UIRefreshControl()
    var selectedCell: Int?
    var selectedAirport: Airport?
    var airports = [Airport]()
    var filteredAirports = [Airport]()
    var isDestination = false
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
        self.navigationItem.title = "Airports"
        mainTableview.register(AirportListCell.self, forCellReuseIdentifier: Constants.AIRPORT_CELL)
        mainTableview.tableFooterView = UIView()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "leftArrow"), style: .plain, target: self, action: #selector(back))
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .white
        self.configureSearchController()
        viewModel = AirportListViewModel(with: NetworkManager(),
                                         refreshControl: refreshControl.rx.controlEvent(.valueChanged).asDriver())
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        self.searchController.isActive = false
    }

    func configureSearchController() {
        self.searchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.hidesNavigationBarDuringPresentation = false
            controller.searchBar.sizeToFit()
            controller.searchBar.setShowsCancelButton(false, animated: true)
            controller.searchBar.keyboardAppearance = .default
            controller.searchBar.placeholder = "Search for aiports"
            self.mainTableview.tableHeaderView = controller.searchBar
            return controller
        })()
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
        return  !searchBarIsEmpty()
    }
}
