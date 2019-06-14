//
//  FlightScheduleUI+extension.swift
//  SkyFind
//
//  Created by Angie Mugo on 13/06/2019.
//  Copyright © 2019 Angie Mugo. All rights reserved.
//

extension FlightScheduleController {
    func setupUI() {
        self.view.addSubview(mainTableview)

        if #available(iOS 11.0, *) {
            mainTableview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            mainTableview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        } else {
            mainTableview.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            mainTableview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
        mainTableview.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        mainTableview.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true

        mainTableview.delegate = self
        mainTableview.dataSource = self
    }
}
