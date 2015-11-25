//
//  MapViewController.swift
//  MapNavigation
//
//  Created by Sravya Dara on 11/18/15.
//  Copyright © 2015 Sravya Dara. All rights reserved.
//


import Foundation
import UIKit
import MapKit
import CoreLocation
import AddressBook

class MapViewController: UIViewController {
    
    var fromStreetdata:String!
    var fromCitydata :String!
    var fromStatedata:String!
    var fromZipdata :Int!
    var toStreetdata:String!
    var toCitydata :String!
    var toStatedata :String!
    var toZipdata :Int!
    
    
    @IBOutlet var mapView: MKMapView!
    
       override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let fromAddress = "\(fromStreetdata) \(fromCitydata) \(fromStatedata) \(fromZipdata)"
        let toAddress = "\(toStreetdata) \(toCitydata) \(toStatedata) \(toZipdata)"
        
        let geocoder1 = CLGeocoder()
        let geocoder2 = CLGeocoder()
        
        geocoder1.geocodeAddressString(fromAddress, completionHandler: {(placemarks, error) -> Void in
            if((error) != nil){
                print("Error", error)
            }
            if let placemark = placemarks?.first {
                var coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                let region = MKCoordinateRegionMakeWithDistance(coordinates, 10000.0, 100000.0)
                self.mapView.setRegion(region, animated: true)
                self.mapView.zoomEnabled = true
                self.mapView.addAnnotation(MKPlacemark(placemark: placemark))
                
                
            }
        })
        
        
        geocoder2.geocodeAddressString(toAddress, completionHandler: {(placemarks, error) -> Void in
            if((error) != nil){
                print("Error", error)
            }
            if let placemark = placemarks?.first {
                var coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                let region = MKCoordinateRegionMakeWithDistance(coordinates, 10000.0, 100000.0)
                self.mapView.setRegion(region, animated: true)
                self.mapView.zoomEnabled = true
                self.mapView.addAnnotation(MKPlacemark(placemark: placemark))
                
                
            }
        })

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}