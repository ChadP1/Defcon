//
//  apiEngine.swift
//  Defcon
//
//  Created by chad parr on 5/11/16.
//  Copyright © 2016 chad parr. All rights reserved.
//

import Foundation
import SwiftyJSON


class apiEngine {
    
    
    func getTemp(tempFetch:(temp: String, success: Bool) -> Void) {
        
        
        let session = NSURLSession.sharedSession()
        
        let weatherUrl = NSURL(string: "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22nome%2C%20ak%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys")!
        
        session.dataTaskWithURL(weatherUrl) { (data, response, error) in
            
            if error == nil && data != nil {
                
                do{
                
                let weatherDict = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! [String: AnyObject]
                    
                    if let query = weatherDict["query"] as? [String:AnyObject] {
                        
                        if let results = query["results"] as? [String:AnyObject] {
                            
                            
                            if let channel = results["channel"] as? [String:AnyObject] {
                                
                                
                                if let item = channel["item"] as? [String:AnyObject] {
                                    
                                    
                                    if let condition = item["condition"] as? [String:AnyObject] {
                                        
                                        
                                        if let temp = condition["temp"] as? String {
                                            
                                            tempFetch(temp: temp, success: true)
                                            print(temp)
                                            
                                        }

                                        
                                    }

                                    
                                    
                                    
                                }

                                
                                
                                
                            }

                            
                        }

                        
                    }
                    
                    
                } catch {
                    
                tempFetch(temp: "", success: false)

                
                }
                
            } else {
                
                tempFetch(temp: "", success: false)
                
            }
            
        }.resume()
        
        
    }
    
    
    
    func retrieveAir(tempFetch:(datetime: String, countryName: String, breezoAqi: String, breezoAQIColor: String, describe: String, countryAQI: Int, children: String, sport: String, health: String, inside: String, outside: String, dpc: String, dpd: String, color: String, cause: String, main: String, outisde: String, success: Bool) -> Void) {
        
        var one, two, three, four, five, six, seven, eight, nine, colored, c, m, o : String!
        
        let session = NSURLSession.sharedSession()
        
        let weatherUrl = NSURL(string: "https://api.breezometer.com/baqi/?lat=\(final_lat)&lon=\(final_long)&key=a5c51ea836fb4637a2a274107cc1f58a")!
        
        session.dataTaskWithURL(weatherUrl) { (data, response, error) in
            
            if error == nil && data != nil {
                
                do{
                    
                    let aqiDict = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! [String: AnyObject]
                    
                    if let dates = aqiDict["datetime"] as? String {
                        
                        print(dates)
                        one = dates
                       
                    }
                    
                    if let countryN = aqiDict["country_name"] as? String {
                        
                        print(countryN)
                        two = countryN
                        
                        
                    }
                    
                    if let bAQI = aqiDict["breezometer_aqi"] as? Int {
                        
                        
                        print(bAQI)
                        three = "\(bAQI)"
                        
                    }
                    
                    if let des = aqiDict["breezometer_description"] as? String {
                        
                        print(des)
                        four = des
                        
                    }
                    
                    if let countryQuality = aqiDict["country_aqi"] as? Int {
                        
                        print(countryQuality)
                        
                    }
                    
                    if let recommend = aqiDict["random_recommendations"] as? [String:AnyObject] {
                     
                        if let child = recommend["children"] as? String {
                            
                            print(child)
                            five = child
                            
                        }
                        
                        if let sporty = recommend["sport"] as? String {
                            
                            print(sporty)
                            six = sporty
                            
                        }
                        
                        if let health = recommend["health"] as? String {
                            
                            print(health)
                            seven = health
                            
                        }
                        
                        if let inner = recommend["inside"] as? String {
                            
                            print(inner)
                            eight = inner
                        }
                        
                        if let outy = recommend["outside"] as? String {
                            
                            print(outy)
                            o = outy
                        }
                        
                    }
                    
                    if let colord = aqiDict["breezometer_color"] as? String {
                        
                        colored = colord
                        
                    }
                    
                    
                    if let dpcn = aqiDict["dominant_pollutant_canonical_name"] as? String {
                        
                        print(dpcn)
                        nine = dpcn
                        
                    }
                    
                    if let  dpc = aqiDict["dominant_pollutant_description"] as? String {
                        
                        print(dpc)
                        
                    }
                    
                    
                    if let dpt = aqiDict["dominant_pollutant_text"] as? [String:AnyObject] {
                        
                        if let mainText = dpt["main"] as? String {
                            
                            print("Main " + mainText)
                            
                        }
                        
                        if let effectText = dpt["effects"] as? String {
                            
                            print("Effect " + effectText)
                            m = effectText
                        }
                        
                        if let causeText = dpt["causes"] as? String {
                            
                            print("Cause " + causeText)
                            c = causeText
                        }
                        
                        
                    }
                    
                 
                    tempFetch(datetime: one, countryName: two, breezoAqi: three, breezoAQIColor: "", describe: four, countryAQI: 0, children: five, sport: six, health: seven, inside: eight, outside: "", dpc: nine, dpd: "", color: colored, cause : c, main : m, outisde: o, success: true)
                    
                } catch {
                    
                    
                    
                    
                }
                
            } else {
                
                
                
            }
            
            }.resume()

        
        
        
        
    }
    
    
    func locationAdd(addFetch:(city: String, success: Bool) -> Void) {
        
        let session = NSURLSession.sharedSession()
        
        let weatherUrl = NSURL(string: "https://maps.googleapis.com/maps/api/geocode/json?latlng=\(final_lat),\(final_long)&key=AIzaSyCKXi20qzTV4RXWEXsNlLU_XZlBiUdN4VA")!
        
        session.dataTaskWithURL(weatherUrl) { (data, response, error) in
            
            if error == nil && data != nil {
                
                do{
                    
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) //as! [String: AnyObject]
                    
                    
                    if let locale = json["results"] as? [[String: AnyObject]] {
                     
                        for places in locale {

                            if let formattedAdress = places["formatted_address"] as? String {
                                
                            print(formattedAdress)
                                
                                 addFetch(city: formattedAdress, success: true)
                            
                            }
                            
                        }
                        
                        
                    }
                    
                    
                } catch {
                    
                    addFetch(city:"", success: false)
                    
                    
                }
                
            } else {
                
                addFetch(city: "", success: false)
                
            }
            
            }.resume()
        
    }
}

































