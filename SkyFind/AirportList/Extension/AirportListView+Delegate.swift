//
//  AirportListView+Delegate.swift
//  SkyFind
//
//  Created by Angie Mugo on 11/06/2019.
//  Copyright © 2019 Angie Mugo. All rights reserved.
//
import UIKit

extension AirportListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredAirports.count
        }
        return airports.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.AIRPORT_CELL, for: indexPath) as! AirportListCell
        if isFiltering() {
            cell.airport = filteredAirports[indexPath.row]
        } else {
            cell.airport = airports[indexPath.row]
        }
        if let row = selectedCell {
            cell.accessoryType = indexPath.row == row ? .checkmark : .none
        }
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCell = indexPath.row
        selectedAirport = airports[indexPath.row]
        self.mainTableview.reloadData()
    }

    func updateSearchResults(for searchController: UISearchController) {
        filteredAirports.removeAll()
        filterContentForSearchText(searchController.searchBar.text ?? "")
    }
}
