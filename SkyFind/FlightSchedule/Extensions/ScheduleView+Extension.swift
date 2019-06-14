//
//  ScheduleView+Extension.swift
//  SkyFind
//
//  Created by Angie Mugo on 14/06/2019.
//  Copyright © 2019 Angie Mugo. All rights reserved.
//

import UIKit

extension FlightScheduleController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schedules.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.SCHEDULE_CELL, for: indexPath) as! ScheduleCell
        cell.schedule = schedules.value[indexPath.row]
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let mapView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MapViewController") as? MapViewController else { return }
        mapView.originPosition = originAirport?.position
        mapView.destinationPosition = destinationAiport?.position
        self.navigationController?.pushViewController(mapView, animated: true)
    }

}
