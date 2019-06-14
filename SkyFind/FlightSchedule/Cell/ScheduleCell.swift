//
//  ScheduleCell.swift
//  SkyFind
//
//  Created by Angie Mugo on 14/06/2019.
//  Copyright © 2019 Angie Mugo. All rights reserved.
//

import UIKit

class ScheduleCell: UITableViewCell {

    let flightNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let departLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let arrivalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var schedule: Schedule? {
        didSet {
            setupCell()
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupCell() {
        self.addSubview(flightNameLabel)
        self.addSubview(departLabel)
        self.addSubview(arrivalLabel)
        self.selectionStyle = .none

        guard let schedule = schedule else { return }
        flightNameLabel.text = "From: \(schedule.flight[0].departure.aiportCode), To: \(schedule.flight[0].arrival.aiportCode)"
        departLabel.text = "Departs at: \(schedule.flight[0].departure.scheduledTime.time)"
        arrivalLabel.text = "Arrives at: \(schedule.flight[0].arrival.scheduledTime.time)"

        flightNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        flightNameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        flightNameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true

        departLabel.topAnchor.constraint(equalTo: flightNameLabel.bottomAnchor, constant: 16).isActive = true
        departLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        departLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true

        arrivalLabel.topAnchor.constraint(equalTo: departLabel.bottomAnchor, constant: 16).isActive = true
        arrivalLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        arrivalLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
    }
}
