//
//  customLbl.swift
//  Defcon
//
//  Created by chad parr on 5/12/16.
//  Copyright © 2016 chad parr. All rights reserved.
//


import UIKit
import Foundation

class customLbl: UILabel {
    
    override func awakeFromNib() {
        
        layer.cornerRadius = 2
        clipsToBounds = true 
        
        
        
    }
    

}
