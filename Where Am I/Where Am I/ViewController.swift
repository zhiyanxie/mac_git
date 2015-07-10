//
//  ViewController.swift
//  Where Am I
//
//  Created by Xiezhiyan on 7/10/15.
//  Copyright (c) 2015 Appxie. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate {
    
    var manager : CLLocationManager!
    
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longtitudeLabel: UILabel!
    @IBOutlet weak var courseLabel: UILabel!
    
    
    @IBOutlet weak var speedLabel: UILabel!
    
    @IBOutlet weak var altitudeLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy - kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    
    
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        println(locations)
        
        var userLoaction: CLLocation = locations[0] as! CLLocation
        self.latitudeLabel.text = "\(userLoaction.coordinate.latitude)"
        self.longtitudeLabel.text = "\(userLoaction.coordinate.longitude)"
        self.courseLabel.text="\(userLoaction.course)"
        self.speedLabel.text="\(userLoaction.speed)"
        self.altitudeLabel.text="\(userLoaction.altitude)"
        
        CLGeocoder().reverseGeocodeLocation(userLoaction, completionHandler: { (placemarks,error) -> Void in
            if (error != nil){
                println(error)
            }else{
                if let p = CLPlacemark(placemark: placemarks?[0] as! CLPlacemark){
                    var subThroughfare:String = ""
                    if (p.subThoroughfare != nil){
                        subThroughfare = p.subThoroughfare
                        
                    }
                    self.addressLabel.text="\(p.thoroughfare) \(p.subLocality) \(p.subAdministrativeArea) \(p.postalCode) \(p.country)"
                }
            }
        })
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

