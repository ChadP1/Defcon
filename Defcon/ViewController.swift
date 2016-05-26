//
//  ViewController.swift
//  Defcon
//
//  Created by chad parr on 5/2/16.
//  Copyright © 2016 chad parr. All rights reserved.
//

import UIKit
import VideoSplashKit
import CCHexagonFlowLayout
import CoreLocation


class ViewController: UIViewController, CLLocationManagerDelegate {
    
  
    
    
     var locationManager = CLLocationManager()
     var locale = false
    //buttons
    
    @IBOutlet weak var aqi: honeycombBtn!
    @IBOutlet weak var weather: honeycombBtn!
    @IBOutlet weak var tornado: honeycombBtn!
    @IBOutlet weak var tsunami: honeycombBtn!
    @IBOutlet weak var hurricane: honeycombBtn!
    @IBOutlet weak var earthQuake: honeycombBtn!
    @IBOutlet weak var tides: honeycombBtn!
    
  
    override func viewDidLoad() {
        super.viewDidLoad()

        

    }
    

    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
    }

    
    
    override func viewWillAppear(animated: Bool) {
        
        locationAuthStatus()
        whoAmI()

    }

    
    @IBAction func btnPres(btn: UIButton!) {
        
        if locale {
        
        if btn.tag == 1 {
            
            print("AQI")
            
        } else if btn.tag == 2 {
            
            print("Weather")
            
            
        } else if btn.tag == 3 {
            
            print("Tornado")
            
            
        } else if btn.tag == 4 {
            
            print("Tsunami")
            
            
        } else if btn.tag == 5 {
            
            print("Hurricane")
            
            
        } else if btn.tag == 6 {
            
            print("Earthquake")
            
        } else if btn.tag == 7 {
            
            print("Tides")
            
        }
        
               
        performSegueWithIdentifier("info", sender: nil)
        
        } else {
            
            print("Allow location")
            
        }
            
    }
    
    func whoAmI() {
        
        if DeviceType.IS_IPHONE_4_OR_LESS {
            
           phoneType = "iPhone 4"
            
        } else if DeviceType.IS_IPHONE_5 {
            
            phoneType = "iPhone 5"
            
        } else if DeviceType.IS_IPHONE_6 {
            
             phoneType = "iPhone 6"
            
        } else if DeviceType.IS_IPHONE_6P {
            
            phoneType = "iPhone 6plus"
            
        } else if DeviceType.IS_IPAD {
            
            phoneType = "iPad"
            
        } else if DeviceType.IS_IPAD_PRO {
            
            phoneType = "iPad Pro"
            
        }

        let batterylevel = UIDevice.currentDevice().batteryLevel
        //let ver  =  UIDevice.currentDevice().systemVersion
        //let name = UIDevice.currentDevice().name
        let bright =   Int(UIScreen.mainScreen().brightness * 100)
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        let newDay = dateFormatter.stringFromDate(NSDate())
        
        battLvl = Int(batterylevel)
        brightness = bright
        currentDate = newDay
        
    }
    
    func locationAuthStatus() {
        
        var lat: Double!
        var long: Double!
        var alt: Double!
        var course: AnyObject!
        var des: AnyObject!
        var floor: AnyObject!
        var spd: Double!
        
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            
            lat = self.locationManager.location!.coordinate.latitude
            long = self.locationManager.location!.coordinate.longitude
            alt = self.locationManager.location!.altitude
            course = self.locationManager.location!.course
            des = self.locationManager.location!.description
            floor = self.locationManager.location!.floor
            spd = self.locationManager.location!.speed
            
            final_lat = lat
            final_long = long
            altitude = alt
            speed = Int(spd)
            
            
            print("Altitide \(alt)")
            print("Latitude \(lat)")
            print("Long \(long)")
            print("Course \(course)")
            print("Desc \(des)")
            print("Floor \(floor)")
            print("Speed \(speed)")
            locale = true
        } else {
            
            locationManager.requestWhenInUseAuthorization()
            
        }
        
    }

    

}


//Sigomera

//authen  svRfxndxwqa_3ucJxmtH

//url param ?auth_token=svRfxndxwqa_3ucJxmtH

//http://api.sigimera.org/v1/crises?auth_token=svRfxndxwqa_3ucJxmtH
            
//google key : AIzaSyCKXi20qzTV4RXWEXsNlLU_XZlBiUdN4VA


//breezometer
    
//base https://api.breezometer.com/baqi/?
    
//location location=

//coordinates lat=40.7324296&lon=-73.9977264

//key &key=YOUR_API_KEY


//https://api.breezometer.com/baqi/?location=5th+avenue+new+york+ny+united+states&key=YOUR_API_KEY
// key a5c51ea836fb4637a2a274107cc1f58a

//https://api.breezometer.com/baqi/?location=5th+avenue+new+york+ny+united+states&key=a5c51ea836fb4637a2a274107cc1f58a



enum UIUserInterfaceIdiom : Int
{
    case Unspecified
    case Phone
    case Pad
}

struct ScreenSize
{
    static let SCREEN_WIDTH         = UIScreen.mainScreen().bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.mainScreen().bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

struct DeviceType
{
    static let IS_IPHONE_4_OR_LESS  = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5          = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6          = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P         = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPAD              = UIDevice.currentDevice().userInterfaceIdiom == .Pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
    static let IS_IPAD_PRO          = UIDevice.currentDevice().userInterfaceIdiom == .Pad && ScreenSize.SCREEN_MAX_LENGTH == 1366.0
}








