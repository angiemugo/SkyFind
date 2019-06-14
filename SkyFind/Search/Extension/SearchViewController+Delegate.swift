//
//  SearchViewController+Delegate.swift
//  SkyFind
//
//  Created by Angie Mugo on 11/06/2019.
//  Copyright © 2019 Angie Mugo. All rights reserved.
//

import Foundation

extension SearchViewController: AiportListViewDelegate {
    func getAirport(_ destination: Airport?, _ origin: Airport?) {
        if let destination = destination {
            self.destinationTextField.text = "\(destination.airportCode), \(destination.location)"
            self.destination.accept(destination.airportCode)
        }

        if let origin = origin {
            self.originTextField.text = "\(origin.airportCode), \(origin.location)"
            self.origin.accept(origin.airportCode)
        }
    }
}
