//
//  FlightScheduleViewController.swift
//  SkyFind
//
//  Created by Angie Mugo on 13/06/2019.
//  Copyright © 2019 Angie Mugo. All rights reserved.
//

import UIKit
import MapKit

class FlightScheduleViewController: UIViewController, MKMapViewDelegate {

    var mapView: MKMapView = {
        let view = MKMapView()
        view.mapType = MKMapType.standard
        view.isZoomEnabled = true
        view.isScrollEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        self.setupUI()
    }
}
