//
//  infoScreenVC.swift
//  Defcon
//
//  Created by chad parr on 5/10/16.
//  Copyright © 2016 chad parr. All rights reserved.
//

import UIKit

class infoScreenVC: UIViewController {
      
     let helper = apiEngine()
    
    //first info box
    @IBOutlet weak var tempInfo: UILabel!
    @IBOutlet weak var bannerTwo: UILabel!
    @IBOutlet weak var bannerThree: UILabel!
    @IBOutlet weak var mainDetails: UILabel!
    
    
    //second info box
    @IBOutlet weak var twoOne: UILabel!
    @IBOutlet weak var twoTwo: UILabel!
    
    //third info
    @IBOutlet weak var threeOne: UILabel!
    @IBOutlet weak var threeTwo: UILabel!
    @IBOutlet weak var outside: customLbl!
    
    //fourth info
    @IBOutlet weak var fourOne: UILabel!
    @IBOutlet weak var fourTwo: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func viewDidAppear(animated: Bool) {
        
        
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        
        //tempUpdate()
        getAqi()
        address()
       // mainLbl.text = ""
        
    }
    

    @IBAction func backBtn(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func address() {
        
        helper.locationAdd { (city, success) in
            
            if success {
                
                dispatch_async(dispatch_get_main_queue()) {
                    
                    
                }
                
            }
            
            
        }
        
        
        
    }

    
    func tempUpdate() {
        
       
        
        
        helper.getTemp { (temp, success) in
            if success {
                
                dispatch_async(dispatch_get_main_queue()) {
                    
                    self.tempInfo.text = temp
                    
                }

                
            } else {
                
                print("There was no data")
                
            }
        }
        
       
    }
    
    
    func getAqi() {
        
        
        helper.retrieveAir { (datetime, countryName, breezoAqi, breezoAQIColor, describe, countryAQI, children, sport, health, inside, outside, dpc, dpd,color, cause, main, outisde, success) in
            
            if success {
                
                self.aqiColor(Int(breezoAqi)!)
                
                self.tempInfo.text = "\(breezoAqi)/100"
                self.bannerTwo.text =  String(currentDate)//datetime
                //self.bannerTwo.textColor = UIColor.
                self.bannerThree.text = countryName
                self.mainDetails.text = describe
                
                self.twoOne.text = "Children: \(children)"
                self.twoTwo.text = "Sports Activities: \(sport)"
                
                self.threeOne.text = "Senstive health: \(health)"
                self.threeTwo.text = "Inside: \(inside)"
                
                self.fourOne.text = cause + " " + main
                self.fourTwo.text = "Dominant pollutant is \(dpc)"
                
                self.outside.text = "Outside: " + outisde
                
                
                
            } else {
                
                
                
            }
            
            
        }

        
        
        
        
    }
    
    func aqiColor(aqiNumber: Int) {
        
        
        if aqiNumber >= 80 {
            
            tempInfo.backgroundColor = UIColor.greenColor()
            
        } else if aqiNumber < 80 {
            
            tempInfo.backgroundColor = UIColor.brownColor()
            
        }
        
        
        
        
    }
    
    

}
