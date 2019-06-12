//
//  SearchViewController+Delegate.swift
//  SkyFind
//
//  Created by Angie Mugo on 11/06/2019.
//  Copyright © 2019 Angie Mugo. All rights reserved.
//

import Foundation

extension SearchViewController: AiportListViewDelegate {
    func getAirport(_ airport: String) {
        self.destinationTextField.text = airport
    }
}
