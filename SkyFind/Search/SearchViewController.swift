//
//  SearchViewController.swift
//  SkyFind
//
//  Created by Angie Mugo on 10/06/2019.
//  Copyright © 2019 Angie Mugo. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SearchViewController: UIViewController, UITextFieldDelegate {

    let mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 6/255, green: 119/255, blue: 226/199, alpha: 1)
        return view
    }()

    let mainLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.medium)
        label.text = "SKYFIND"
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let originTextField: UITextField = {
        let textField = UITextField()
        textField.setupDefaultTextfieldConfig()
        textField.attributedPlaceholder = NSAttributedString(string: "Select the airport to depart from",
                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.tag = 0
        let rightImage = UIImageView(frame: CGRect(x: 10, y: 10, width: 32, height: 32))
        rightImage.image = #imageLiteral(resourceName: "rightArrow")
        textField.translatesAutoresizingMaskIntoConstraints = false
        let view = UIView(frame: CGRect(x: 10, y: 10, width: 48, height: 48))
        view.addSubview(rightImage)
        textField.rightView = view
        textField.rightViewMode = .always
        return textField
    }()

    let destinationTextField: UITextField = {
        let textField = UITextField()
        textField.setupDefaultTextfieldConfig()
        textField.attributedPlaceholder = NSAttributedString(string: "Select your destination airport",
                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.tag = 1
        textField.translatesAutoresizingMaskIntoConstraints = false

        let rightImage = UIImageView(frame: CGRect(x: 10, y: 10, width: 32, height: 32))
        rightImage.image = #imageLiteral(resourceName: "rightArrow")
        textField.translatesAutoresizingMaskIntoConstraints = false
        let view = UIView(frame: CGRect(x: 10, y: 10, width: 48, height: 48))
        view.addSubview(rightImage)
        textField.rightView = view
        textField.rightViewMode = .always
        return textField
    }()

    let dateTextField: UITextField = {
        let textField = UITextField()
        textField.setupDefaultTextfieldConfig()
        textField.attributedPlaceholder = NSAttributedString(string: "Select the dates",
                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.translatesAutoresizingMaskIntoConstraints = false

        let rightImage = UIImageView(frame: CGRect(x: 10, y: 10, width: 32, height: 32))
        rightImage.image = #imageLiteral(resourceName: "downArrow")
        textField.translatesAutoresizingMaskIntoConstraints = false
        let view = UIView(frame: CGRect(x: 10, y: 10, width: 48, height: 48))
        view.addSubview(rightImage)
        textField.rightView = view
        textField.rightViewMode = .always
        return textField
    }()

    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePicker.Mode.date
        return datePicker
    }()

    let searchButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.yellow_background
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle("Search", for: .normal)
        button.layer.cornerRadius = 6
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let disposeBag = DisposeBag()
    var viewModel: SearchViewModel? {
        didSet {
            setupViewModel()
        }
    }

    //because RXSwift does not detect changes in textfield unless they are triggered by the user. In this case mine were triggered by the table view. Could be done better
    var origin = BehaviorRelay<String>(value: "origin")
    var destination = BehaviorRelay<String>(value: "date")
    var date = BehaviorRelay<String>(value: "")
    var destinationAirport: Airport?
    var originAirport: Airport?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        self.view.endEditing(true)
        viewModel = SearchViewModel(withManager: NetworkManager(),
                                    origin: origin.asDriver(),
                                    destination: destination.asDriver(),
                                    date: date.asDriver(),
                                    searchButton: searchButton.rx.tap.asDriver())
    }  
}
