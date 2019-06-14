//
//  MapViewController.swift
//  SkyFind
//
//  Created by Angie Mugo on 14/06/2019.
//  Copyright © 2019 Angie Mugo. All rights reserved.
//

import UIKit
import MapKit
import RxSwift
import RxCocoa

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet var mapView: MKMapView!
    var originPosition: Position?
    var destinationPosition: Position?

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.showsPointsOfInterest = true
        mapView.delegate = self
        self.setupUI()
        self.createPolyline()
    }
}
