//
//  AirportViewModel+Extension.swift
//  SkyFind
//
//  Created by Angie Mugo on 12/06/2019.
//  Copyright © 2019 Angie Mugo. All rights reserved.
//

extension AirportListViewController {
    func setupViewModel() {
        if !isViewLoaded { return }
        guard let viewModel = viewModel else { return }

        viewModel.isLoading.drive(onNext: { [unowned self] (value) in
            if value { self.refreshControl.beginRefreshing() }
            else { self.refreshControl.endRefreshing() }
        }).disposed(by: disposeBag)

        viewModel.errorMsg.drive(onNext: { [unowned self] (value) in
            guard value.count > 0 else { return }
            self.showNilAlert("Airports", body: value)
        }).disposed(by: disposeBag)

        viewModel.airports.drive(onNext: { [unowned self] (value) in
            self.airports = value
            self.mainTableview.reloadData()
        }).disposed(by: disposeBag)
    }
}
