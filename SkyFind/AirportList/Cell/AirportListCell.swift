//
//  AirportListCell.swift
//  SkyFind
//
//  Created by Angie Mugo on 11/06/2019.
//  Copyright © 2019 Angie Mugo. All rights reserved.
//

import UIKit

class AirportListCell: UITableViewCell {

    let airportCodeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let airportNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var airport: Airport? {
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
        self.addSubview(airportCodeLabel)
        self.addSubview(airportNameLabel)
        self.selectionStyle = .none

        guard let airport = airport else { return }
        airportNameLabel.text = airport.location
        airportCodeLabel.text = "\(airport.airportCode), \(airport.name.name[0].airportName)"
        airportCodeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        airportCodeLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        airportCodeLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true

        airportNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        airportNameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        airportNameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
    }
}
