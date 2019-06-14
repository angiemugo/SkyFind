//
//  LoaderView.swift
//  SkyFind
//
//  Created by Angie Mugo on 14/06/2019.
//  Copyright © 2019 Angie Mugo. All rights reserved.
//

import UIKit

class LoaderView: UIView {

    @IBOutlet var mainView: UIView!
    let backgroundView: UIView! = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 10
        view.elevate()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .gray
        indicator.color = UIColor.gray
        indicator.startAnimating()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    let loaderInformation: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.bold)
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = "Loading..."
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setupViews()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    func setupViews() {
        self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.addSubview(backgroundView)

        // x, y, width and height of backgroundView
        backgroundView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        backgroundView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        backgroundView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        backgroundView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        backgroundView.addSubview(loaderInformation)
        backgroundView.addSubview(activityIndicator)

        // x, y of indicator
        activityIndicator.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor).isActive = true

        // x, y, width, height
        loaderInformation.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -16).isActive = true
        loaderInformation.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
        loaderInformation.widthAnchor.constraint(equalTo: backgroundView.widthAnchor, constant: -16).isActive = true
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
}
