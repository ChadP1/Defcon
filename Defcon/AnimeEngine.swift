//
//  AnimeEngine.swift
//  Defcon
//
//  Created by chad parr on 5/2/16.
//  Copyright © 2016 chad parr. All rights reserved.
//

import UIKit
import pop

class AnimeEngine {
    
    
    class var offScreenRightPosition: CGPoint {
        
        return CGPointMake(UIScreen.mainScreen().bounds.width, CGRectGetMidY(UIScreen.mainScreen().bounds))
        
    }
    
    class var offScreenLeftPosition: CGPoint {
        
        return CGPointMake(-UIScreen.mainScreen().bounds.width, CGRectGetMidY(UIScreen.mainScreen().bounds))
    }
    
    class var screenCenterPosition: CGPoint {
        
        return CGPointMake(CGRectGetMidX(UIScreen.mainScreen().bounds), CGRectGetMidY(UIScreen.mainScreen().bounds))
        
    }
    
    
    
    var originalConstants = [CGFloat]()
    var constraints : [NSLayoutConstraint]!
    
    
    init(constraints: [NSLayoutConstraint]) {
        
        for con in constraints {
            
            originalConstants.append(con.constant)
            con.constant = AnimeEngine.offScreenRightPosition.x
            
        }
        
        self.constraints = constraints
        
        
    }
    
    func animateOnScreen() {
        
        
        var index = 0
        
        repeat {
            
            let moveAnim = POPSpringAnimation(propertyNamed: kPOPLayoutConstraintConstant)
            moveAnim.toValue = self.originalConstants[index]
            moveAnim.springBounciness = 12
            moveAnim.springSpeed = 12
            
            let con = self.constraints[index]
            con.pop_addAnimation(moveAnim, forKey: "moveOnScreen")
            
            index = index + 1
            
            
        } while (index < self.constraints.count)
        
        
        
    }
    
    
}
