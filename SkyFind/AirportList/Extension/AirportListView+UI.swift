//
//  AirportListView+UI.swift
//  SkyFind
//
//  Created by Angie Mugo on 11/06/2019.
//  Copyright © 2019 Angie Mugo. All rights reserved.
//

import Foundation

extension AirportListViewController {

    func setupUI() {
        self.view.addSubview(mainView)
        self.view.addSubview(mainTableview)

        if #available(iOS 11.0, *) {
            mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        } else {
            mainView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
        mainView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        mainView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true

        mainTableview.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 8).isActive = true
        mainTableview.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -8).isActive = true
        mainTableview.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 8).isActive = true
        mainTableview.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -8).isActive = true

        mainTableview.delegate = self
        mainTableview.dataSource = self
    }

    @objc func back() {
        guard let airport = selectedAirport else { return }
        delegate?.getAirport(airport)
        self.navigationController?.popViewController(animated: true)
    }
}
