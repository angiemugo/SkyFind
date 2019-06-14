//
//  SearchViewModel+Extension.swift
//  SkyFind
//
//  Created by Angie Mugo on 14/06/2019.
//  Copyright © 2019 Angie Mugo. All rights reserved.
//

extension SearchViewController {
    func setupViewModel() {
        if !isViewLoaded { return }
        guard let viewModel = viewModel else { return }

        viewModel.appProgress.drive(onNext: { [unowned self] (value) in
            Loader.sharedInstance.genericInitialze(show: value.loading)

            if value.message.count > 0 {
                if let _ = value.done {
                    let view = FlightScheduleViewController()
                    viewModel.schedules.drive(onNext: { [weak self] value in
                        view.destinations.accept(value)
                    }).disposed(by: self.disposeBag)
                    self.navigationController?.pushViewController(view, animated: true)
                } else {
                    self.showNilAlert("Search", body: value.message)
                }
            }
        })
    }
}
