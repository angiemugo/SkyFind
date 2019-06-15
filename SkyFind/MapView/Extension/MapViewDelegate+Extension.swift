//
//  MapView+Delegate.swift
//  SkyFind
//
//  Created by Angie Mugo on 14/06/2019.
//  Copyright © 2019 Angie Mugo. All rights reserved.
//

import UIKit
import MapKit

extension MapViewController {

    func setupUI() {
        mapView.showsPointsOfInterest = true
    }

    func createPolyline() {
        guard let origin = originPosition else { return }
        guard let destination = destinationPosition else { return }

        let locations = [CLLocation(latitude: origin.coordinate.latitude, longitude: origin.coordinate.longitude), CLLocation(latitude: destination.coordinate.latitude, longitude: destination.coordinate.longitude)]
        var coordinates = locations.map({(location: CLLocation!) -> CLLocationCoordinate2D in return location.coordinate})
        let aPolyline = MKPolyline(coordinates: &coordinates, count: locations.count)
        mapView.addOverlay(aPolyline)
        zoomToPolyLine(map: mapView, polyLine: aPolyline, animated: true)
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            let polylineRender  = MKPolylineRenderer(overlay: overlay)
            polylineRender.strokeColor = UIColor.blue
            polylineRender.lineWidth = 2.0
            return polylineRender
        }

        return MKPolylineRenderer()
    }

    func zoomToPolyLine(map : MKMapView, polyLine : MKPolyline, animated : Bool){
        map.setRegion(MKCoordinateRegion(polyLine.boundingMapRect), animated: animated)
    }
}
