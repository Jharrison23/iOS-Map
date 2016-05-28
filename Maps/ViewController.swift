//
//  ViewController.swift
//  Maps
//
//  Created by James Harrison on 5/20/16.
//  Copyright © 2016 James Harrison. All rights reserved.
//

import UIKit

////import MapKit to fix the error with MKMapView
import MapKit

////import coreLocation to get users current location
import CoreLocation

////add MKMapViewDelegate and CLLocationMangerDelegate to function protocal, for use in the function
class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate
{

    //// Held control and dragged our map view UI to the code to link the user interface to the code through an outlet
    @IBOutlet weak var mapView: MKMapView!
    
    ////Label to display the speed and method of transportation
    @IBOutlet weak var label: UILabel!
    
    ////Create a location manager property
    let locationManager = CLLocationManager()
    
    
    
    ////Set up location manager, so we can find the current location after the view loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ////Conform to delagate method
        self.locationManager.delegate = self
        
        ////Gets the best accuracy for the users location
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        ////Only user location services when youre using the app, not when the app is in the background
        self.locationManager.requestWhenInUseAuthorization()
        
        ////Turn on the locatio manager to look for location
        self.locationManager.startUpdatingLocation()
        
        ////shows the blue dot marking the user location on the map
        self.mapView.showsUserLocation = true
        
        
        ////Changes the color of the User location icon
        mapView.tintColor = UIColor.greenColor()
        
        
        ////This is how i think ill end up changing the picture
        //        var userIcon = mapView.dequeueReusableAnnotationViewWithIdentifier("image")
        //        userIcon = MKAnnotationView(annotation: annotation, reuseIdentifier: "image")
        //        userIcon!.image = UIImage(named: "image")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //// MARK: - Location Delegate Methods
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        ////didUpdateLocations will run until we stop it, once startUpdatingLocation executes, so this gets most current location
        let location = locations.last
    
        ////Get the center out of that location variable
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
    
        ////create a region, basically a circle that the map zooms to, MKCoordinateSpan controls how much it zooms, smaller the number the closer zoom
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        
        ////set the mapview to the region created above, at the latitude and longitude from center, set animated to true so you get the zoom animation
        //self.mapView.setRegion(region, animated: true)
        
        ////Once we have gotten the users current location and the map view is zoomed in, stop updating the current location
        //self.locationManager.stopUpdatingLocation()
        
        
        ////Varible for speed of type double, from CLLocationSpeed
        var speed: CLLocationSpeed = CLLocationSpeed()
        speed = locationManager.location!.speed
        
        ////Stops the location manager from pausing the location updates, which stopped speed from being updated
        //locationManager.pausesLocationUpdatesAutomatically = false;
        print(speed);
        
        ////Convert to mph
        let mph = speed * 2.237
        
        ////if the speed is less than 2 MPH
        if mph < 2.00
        {
            ////Change the user location icon to purple
            mapView.tintColor = UIColor.purpleColor()
            
            ////Display the speed as a string to the label, "\()" converts the value to a string
            label.text = "Speed: \(mph) MPH, Walk"
        }
            
            ////if the speed is 2 > MPH < 4
        else if mph >= 2.00 && mph <= 4.00
        {
            ////Change the user location icon to blue
            mapView.tintColor = UIColor.blueColor()
            
            ////Display the speed as a string to the label, "\()" converts the value to a string
            label.text = "Speed: \(mph) MPH, Fast Walk"
        }
            
            
            ////if the speed 4 > MPH < 7
        else if mph > 4.00 && mph <= 7.00
        {
            ////Change the user location icon to purple
            mapView.tintColor = UIColor.greenColor()
            
            ////Display the speed as a string to the label, "\()" converts the value to a string
            label.text = "Speed: \(mph) MPH, Running"
        }
            
            ////if the speed > 7
        else if mph > 7.00
        {
            ////Change the user location icon to purple
            mapView.tintColor = UIColor.redColor()
            
            ////Display the speed as a string to the label, "\()" converts the value to a string
            label.text = "Speed: \(mph) MPH, Driving"
        }
        
        
    }

        
    
    
    
    //// MARK: - ERROR management
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        
        ////prints out an error to the debugger if we have one with the location manager
        print("Errors : " + error.localizedDescription)
    }
    


}

