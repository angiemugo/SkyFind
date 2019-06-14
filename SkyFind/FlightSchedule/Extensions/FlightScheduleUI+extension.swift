//
//  FlightScheduleUI+extension.swift
//  SkyFind
//
//  Created by Angie Mugo on 13/06/2019.
//  Copyright © 2019 Angie Mugo. All rights reserved.
//

import UIKit
import MapKit

extension FlightScheduleViewController {

    func setupUI() {
        let mapView = MKMapView()

        mapView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.showsPointsOfInterest = true

        mapView.center = view.center
        view.addSubview(mapView)
        createPolyline()
    }

    func createPolyline() {
        let locations = [CLLocation(latitude: 32, longitude: -96), CLLocation(latitude: 37, longitude: -122)]
        var coordinates = locations.map({(location: CLLocation!) -> CLLocationCoordinate2D in return location.coordinate})

        let aPolyline = MKPolyline(coordinates: &coordinates, count: locations.count)
        mapView.addOverlay(aPolyline)
        zoomToPolyLine(map: mapView, polyLine: aPolyline, animated: true)
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            let polylineRender  = MKPolylineRenderer(overlay: overlay)
            polylineRender.strokeColor = UIColor.blue.withAlphaComponent(0.5)
            polylineRender.lineWidth = 5
            return polylineRender
        }

        return MKPolylineRenderer()
    }


    func zoomToPolyLine(map : MKMapView, polyLine : MKPolyline, animated : Bool){
        map.setRegion(MKCoordinateRegion(polyLine.boundingMapRect), animated: animated)
    }
}
