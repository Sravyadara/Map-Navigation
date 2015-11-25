//
//  ViewController.swift
//  MapKit
//
//  Created by Sravya Dara on 11/18/15.
//  Copyright © 2015 Sravya Dara. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var fromStreet: UITextField!
    @IBOutlet weak var fromState: UITextField!
    @IBOutlet weak var fromCity: UITextField!
    @IBOutlet weak var fromZip: UITextField!
    
    @IBOutlet weak var toStreet: UITextField!
    @IBOutlet weak var toCity: UITextField!
    @IBOutlet weak var toZip: UITextField!
    @IBOutlet weak var toState: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "map"{
            
        let mapView = segue.destinationViewController as! MapViewController
            mapView.fromStreetdata = fromStreet.text!
            mapView.fromCitydata = fromCity.text!
            mapView.fromStatedata = fromState.text!
            mapView.fromZipdata = Int(fromZip.text!)
            mapView.toStreetdata = toStreet.text!
            mapView.toCitydata = toCity.text!
            mapView.toStatedata = toState.text!
            mapView.toZipdata = Int(toZip.text!)
            
        }
        else if segue.identifier == "route"{
            
            let routeView = segue.destinationViewController as! RouteViewController
            routeView.fromStreetdata = fromStreet.text!
            routeView.fromCitydata = fromCity.text!
            routeView.fromStatedata = fromState.text!
            routeView.fromZipdata = Int(fromZip.text!)
            routeView.toStreetdata = toStreet.text!
            routeView.toCitydata = toCity.text!
            routeView.toStatedata = toState.text!
            routeView.toZipdata = Int(toZip.text!)
            
        }
    }

    


}

