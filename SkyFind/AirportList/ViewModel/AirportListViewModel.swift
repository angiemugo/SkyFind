//
//  AirportListViewModel.swift
//  SkyFind
//
//  Created by Angie Mugo on 11/06/2019.
//  Copyright © 2019 Angie Mugo. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class AirportListViewModel {

    private let manager: NetworkManager

    private let _airports = BehaviorRelay<[Airport]>(value: [Airport]())
    private let _isLoading = BehaviorRelay<Bool>(value: false)
    private let _errorMsg = BehaviorRelay<String>(value: "")

    var airports: Driver<[Airport]> { return _airports.asDriver() }
    var isLoading: Driver<Bool> { return _isLoading.asDriver() }
    var errorMsg: Driver<String> { return _errorMsg.asDriver() }

    private let disposeBag = DisposeBag()

    init(with manager: NetworkManager, refreshControl: Driver<Void>) {
        self.manager = manager

        refreshControl.drive(onNext: { [weak self] () in
            guard let self = self else { return }

            if !self._isLoading.value {
                self.fetchAirportData()
            }
        }).disposed(by: disposeBag)

        self.fetchAirportData()
    }

    func fetchAirportData() {
        if self._isLoading.value { return }
        self._isLoading.accept(true)

        manager.getAirports { response, error in
            if let error = error {
                self._isLoading.accept(false)
                self._errorMsg.accept(error.debugDescription)
            }

            if let response = response {
                self._isLoading.accept(false)
                self._airports.accept(response)
            }
        }
    }
}
