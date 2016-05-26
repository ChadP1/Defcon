//
//  honeycombBtn.swift
//  Defcon
//
//  Created by chad parr on 5/6/16.
//  Copyright © 2016 chad parr. All rights reserved.
//

import UIKit
import pop 

class honeycombBtn: UIButton {

    override func awakeFromNib() {
        
        //layer.cornerRadius = 5
        layer.borderWidth = 2
        layer.borderColor = UIColor.blueColor().CGColor
        
        
        let lineWidth: CGFloat = 5.0;
        let path = UIBezierPath(roundedPolygonPathWithRect:layer.bounds, lineWidth: lineWidth, sides: 6, cornerRadius: 30)
        
        let mask = CAShapeLayer()
        mask.path            = path.CGPath
        mask.lineWidth       = lineWidth
        mask.strokeColor     = UIColor.clearColor().CGColor
        mask.fillColor       = UIColor.whiteColor().CGColor
        layer.mask = mask
        
        let border = CAShapeLayer()
        border.path          = path.CGPath
        border.lineWidth     = lineWidth
        //border.strokeColor   = UIColor.blackColor().CGColor
        //border.fillColor     = UIColor.clearColor().CGColor
        //layer.addSublayer(border)
        
        
        self.addTarget(self, action: #selector(customBtn.scaleToSmall), forControlEvents: .TouchDown)
        self.addTarget(self, action: #selector(customBtn.scaleToSmall), forControlEvents: .TouchDragEnter)
        self.addTarget(self, action: #selector(customBtn.scaleAnimation), forControlEvents: .TouchUpInside)
        self.addTarget(self, action: #selector(customBtn.scaleDef), forControlEvents: .TouchDragExit)

        
        clipsToBounds = true 
        
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

extension UIBezierPath {
    
    /// Create UIBezierPath for regular polygon with rounded corners
    ///
    /// - parameter roundedPolygonPathWithRect:  The CGRect of the square in which the path should be created.
    /// - parameter lineWidth:                   The width of the stroke around the polygon. The polygon will be inset such that the stroke stays within the above square.
    /// - parameter sides:                       How many sides to the polygon (e.g. 6=hexagon; 8=octagon, etc.).
    /// - parameter cornerRadius:                The radius to be applied when rounding the corners.
    
    convenience init(roundedPolygonPathWithRect rect: CGRect, lineWidth: CGFloat, sides: NSInteger, cornerRadius: CGFloat) {
        self.init()
        
        let theta = CGFloat(2.0 * M_PI) / CGFloat(sides)                            // how much to turn at every corner
        let offset = CGFloat(cornerRadius) * CGFloat(tan(theta / 2.0))              // offset from which to start rounding corners
        let squareWidth = min(rect.size.width, rect.size.height)          // width of the square
        
        // calculate the length of the sides of the polygon
        
        var length = squareWidth - lineWidth
        if sides % 4 != 0 {                                               // if not dealing with polygon which will be square with all sides ...
            length = length * CGFloat(cos(theta / 2.0)) + offset/2.0               // ... offset it inside a circle inside the square
        }
        let sideLength = length * CGFloat(tan(theta / 2.0))
        
        // start drawing at `point` in lower right corner
        
        var point = CGPoint(x: squareWidth / 2.0 + sideLength / 2.0 - offset, y: squareWidth - (squareWidth - length) / 2.0)
        var angle = CGFloat(M_PI)
        moveToPoint(point)
        
        // draw the sides and rounded corners of the polygon
        
        for _ in 0 ..< sides {
            point = CGPoint(x: point.x + CGFloat(sideLength - offset * 2.0) * CGFloat(cos(angle)), y: point.y + CGFloat(sideLength - offset * 2.0) * CGFloat(sin(angle)))
            addLineToPoint(point)
            
            let center = CGPoint(x: point.x + cornerRadius * CGFloat(cos(angle + CGFloat(M_PI_2))), y: point.y + cornerRadius * CGFloat(sin(angle + CGFloat(M_PI_2))))
            addArcWithCenter(center, radius:CGFloat(cornerRadius), startAngle:angle - CGFloat(M_PI_2), endAngle:angle + theta - CGFloat(M_PI_2), clockwise:true)
            
            point = currentPoint // we don't have to calculate where the arc ended ... UIBezierPath did that for us
            angle += theta
        }
        
        closePath()
    }
    
}