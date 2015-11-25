//
//  RouteViewController.swift
//  MapNavigation
//
//  Created by Sravya Dara on 11/18/15.
//  Copyright © 2015 Sravya Dara. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import AddressBook
import CoreLocation

class RouteViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{
    
    var fromStreetdata:String!
    var fromCitydata :String!
    var fromStatedata:String!
    var fromZipdata :Int!
    var toStreetdata:String!
    var toCitydata :String!
    var toStatedata :String!
    var toZipdata :Int!
    var source:MKMapItem = MKMapItem()
    var destination:MKMapItem = MKMapItem()
    var points:[CLLocationCoordinate2D] = []
    var locationManager: CLLocationManager!
    var toAddress :String!
    var fromAddress :String!
    var counter = 0

    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        self.mapView.delegate = self
        self.fromAddress = "\(fromStreetdata) \(fromCitydata) \(fromStatedata) \(fromZipdata)"
        self.toAddress = "\(toStreetdata) \(toCitydata) \(toStatedata) \(toZipdata)"
        geocodeAddressString(fromAddress)
        geocodeAddressString(toAddress)
        
    }
    
    func geocodeAddressString(address:String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address, completionHandler:{(placemarks, error) -> Void in
            if let placemark = placemarks?.first {
                let coordinates = placemark.location!.coordinate
                let latitude = coordinates.latitude
                let longitude = coordinates.longitude
                
                let location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude,longitude: longitude)
                let region = MKCoordinateRegionMakeWithDistance(coordinates, 100000.0, 1000000.0)
                self.mapView.setRegion(region, animated: true)
                self.mapView.zoomEnabled = true
                self.mapView.addAnnotation(MKPlacemark(placemark: placemark))
                self.didReceiveGeocodeAddress(location)
                print("counter:",self.counter)
                if(self.counter == 2){
                    self.showRoute()
                }
            }
        })

    }
    
    func didReceiveGeocodeAddress(location: CLLocationCoordinate2D) {
        self.points.append(location)
        print("point :", self.points.count)
        counter = counter + 1
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   func showRoute(){
        let request = MKDirectionsRequest()
        print(self.points[0])
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: self.points[0], addressDictionary: nil))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: self.points[1],addressDictionary: nil))
        request.requestsAlternateRoutes = true
        
        let directions = MKDirections(request: request)
        
        directions.calculateDirectionsWithCompletionHandler { [unowned self] response, error in
            guard let unwrappedResponse = response else { return }
            
            for route in unwrappedResponse.routes {
                print(route.polyline)
                self.mapView.addOverlay(route.polyline)
                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            }
        }
    
    }
    
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
        renderer.lineWidth = 2.0
        renderer.strokeColor = UIColor.blueColor()
        return renderer
    }

    
}