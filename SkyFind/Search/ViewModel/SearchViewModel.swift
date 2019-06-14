//
//  SearchViewModel.swift
//  SkyFind
//
//  Created by Angie Mugo on 10/06/2019.
//  Copyright © 2019 Angie Mugo. All rights reserved.
//

import RxCocoa
import RxSwift

class SearchViewModel {

    private let manager: NetworkManager

    private let _schedules = BehaviorRelay<[Schedule]>(value: [Schedule]())
    private let _origin = BehaviorRelay<String>(value: "")
    private let _destination = BehaviorRelay<String>(value: "")
    private let _date = BehaviorRelay<String>(value: "")
    private let _buttonEnabled = BehaviorRelay<Bool>(value: false)
    private let _appProgress = BehaviorRelay<(message: String, loading: Bool, done: Bool?)>(value: (message: "", loading: false, done: nil))

    var schedules: Driver<[Schedule]> { return _schedules.asDriver() }
    var origin: Driver<String> { return _origin.asDriver() }
    var destination: Driver<String> { return _destination.asDriver() }
    var date: Driver<String> { return _date.asDriver() }
    var buttonEnabled: Driver<Bool> { return _buttonEnabled.asDriver() }
    var appProgress: Driver<(message: String, loading: Bool, done: Bool?)> { return _appProgress.asDriver() }

    private let disposeBag = DisposeBag()

    init(withManager manager: NetworkManager, origin: Driver<String>, destination: Driver<String>, date: Driver<String>, searchButton: Driver<Void>) {
        self.manager = manager

        origin.drive(onNext: { [weak self] (value) in
            self?._origin.accept(value)
        }).disposed(by: disposeBag)

        destination.drive(onNext: { [weak self] (value) in
            self?._destination.accept(value)
        }).disposed(by: disposeBag)

        date.drive(onNext: { [weak self] (value) in
            self?._date.accept(value)
        }).disposed(by: disposeBag)

        searchButton.drive(onNext: { [weak self] () in
            self?.fetchSchedule()
        }).disposed(by: disposeBag)
    }

    func fetchSchedule() {
        guard self._origin.value.count > 0 else {
            self._appProgress.accept((message: "The origin is required.", loading: false, done: nil))
            return
        }

        guard self._destination.value.count > 0 else {
            self._appProgress.accept((message: "The destination is required.", loading: false, done: nil))
            return
        }

        guard self._date.value.count > 0 else {
            self._appProgress.accept((message: "The date is required.", loading: false, done: nil))
            return
        }

        _buttonEnabled.accept(true)
        self.sendData(_origin.value, _destination.value, _date.value)
    }


    func sendData(_ origin: String, _ destination: String, _ date: String) {
        self._appProgress.accept((message: "", loading: true, done: nil))

        manager.getSchedule(origin, destination: destination, date: date) { response, error in
            if let error = error {
                self._appProgress.accept((message: error.debugDescription, loading: false, done: nil))
            }

            if let schedules = response {
                self._schedules.accept(schedules.schedule.schedule)
                self._appProgress.accept((message: "Fetch successful.", loading: false, done: true))
            }
        }
    }
}
