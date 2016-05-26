//
//  customBtn.swift
//  Defcon
//
//  Created by chad parr on 5/2/16.
//  Copyright © 2016 chad parr. All rights reserved.
//

import UIKit
import pop

class customBtn: UIButton {

    override func awakeFromNib() {
        
        //backgroundColor = UIColor(red: 255.0/255, green: 255.0/255, blue: 255.0/255, alpha: 0.5)
        //layer.shadowColor = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1).CGColor
        //layer.shadowOpacity = 0.8
        // layer.shadowRadius = 5.0
        // layer.shadowOffset = CGSizeMake(0.0, 1.0)
        //layer.cornerRadius =  5 //frame.height/2
        layer.borderColor = UIColor.whiteColor().CGColor
        layer.borderWidth = 3
        clipsToBounds = true
        
        self.addTarget(self, action: #selector(customBtn.scaleToSmall), forControlEvents: .TouchDown)
        self.addTarget(self, action: #selector(customBtn.scaleToSmall), forControlEvents: .TouchDragEnter)
        self.addTarget(self, action: #selector(customBtn.scaleAnimation), forControlEvents: .TouchUpInside)
        self.addTarget(self, action: #selector(customBtn.scaleDef), forControlEvents: .TouchDragExit)
        
        
        //setTitleColor(UIColor.blackColor(), forState: .Normal)
        
        
        
    }
    
    
    func scaleToSmall() {
        
        let scaleAnim = POPBasicAnimation(propertyNamed: kPOPLayerScaleXY)
        
        scaleAnim.toValue = NSValue(CGSize: CGSizeMake(0.95, 0.95))
        self.layer.pop_addAnimation(scaleAnim, forKey: "layerScaleSmall")
    }
    
    
    func scaleAnimation() {
        
        let scaleAnim = POPSpringAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleAnim.velocity = NSValue(CGSize: CGSizeMake(3.0, 3.0))
        scaleAnim.toValue = NSValue(CGSize: CGSizeMake(1.0, 1.0))
        scaleAnim.springBounciness = 18
        self.layer.pop_addAnimation(scaleAnim, forKey: "layerSpring")
        
        
    }
    
    func scaleDef() {
        
        let scaleAnim = POPBasicAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleAnim.toValue = NSValue(CGSize: CGSizeMake(1, 1))
        self.layer.pop_addAnimation(scaleAnim, forKey: "default")
        
        
        
    }

}
