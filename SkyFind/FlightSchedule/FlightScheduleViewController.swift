//
//  FlightScheduleViewController.swift
//  SkyFind
//
//  Created by Angie Mugo on 13/06/2019.
//  Copyright © 2019 Angie Mugo. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FlightScheduleController: UIViewController {

    let mainTableview: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var schedules = BehaviorRelay<[Schedule]>(value: [Schedule]())
    var originAirport: Airport?
    var destinationAiport: Airport?

    struct Constants {
        static var SCHEDULE_CELL = "Schedules"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        mainTableview.register(ScheduleCell.self, forCellReuseIdentifier: Constants.SCHEDULE_CELL)
        self.setupUI()
    }
}
