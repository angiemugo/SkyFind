//
//  SearchViewController+UI.swift
//  SkyFind
//
//  Created by Angie Mugo on 10/06/2019.
//  Copyright © 2019 Angie Mugo. All rights reserved.
//
import UIKit

extension SearchViewController {
    func setupUI() {
        view.addSubview(mainView)
            mainView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        mainView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        mainView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        mainView.addSubview(mainLabel)
        mainView.addSubview(originTextField)
        mainView.addSubview(destinationTextField)
        mainView.addSubview(searchButton)
        mainView.addSubview(dateTextField)

        mainLabel.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
        mainLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 48).isActive = true

        originTextField.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 16).isActive = true
        originTextField.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -16).isActive = true
        originTextField.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 32).isActive = true
        originTextField.heightAnchor.constraint(equalToConstant: 55).isActive = true
        originTextField.delegate = self

        destinationTextField.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 16).isActive = true
        destinationTextField.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -16).isActive = true
        destinationTextField.topAnchor.constraint(equalTo: originTextField.bottomAnchor, constant: 32).isActive = true
        destinationTextField.heightAnchor.constraint(equalToConstant: 55).isActive = true
        destinationTextField.delegate = self

        dateTextField.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 16).isActive = true
        dateTextField.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -16).isActive = true
        dateTextField.topAnchor.constraint(equalTo: destinationTextField.bottomAnchor, constant: 32).isActive = true
        dateTextField.heightAnchor.constraint(equalToConstant: 55).isActive = true

        searchButton.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 48).isActive = true
        searchButton.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -48).isActive = true
        searchButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        searchButton.topAnchor.constraint(equalTo: dateTextField.bottomAnchor, constant: 32).isActive = true
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let view = AirportListViewController()
        view.delegate = self
        self.navigationController?.pushViewController(view, animated: true)
        return false
    }

}
