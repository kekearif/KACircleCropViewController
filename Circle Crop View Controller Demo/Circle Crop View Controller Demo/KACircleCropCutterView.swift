//
//  KACircleCropCutterView.swift
//  Circle Crop View Controller
//
//  Created by Keke Arif on 21/02/2016.
//  Copyright © 2016 Keke Arif. All rights reserved.
//

import UIKit

class KACircleCropCutterView: UIView {
    
    override var frame: CGRect {
        
        didSet {
            setNeedsDisplay()
        }
        
    }
    
    override func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool {
        for subview in subviews as [UIView] {
            if !subview.hidden && subview.alpha > 0 && subview.userInteractionEnabled && subview.pointInside(convertPoint(point, toView: subview), withEvent: event) {
                return true
            }
        }
        return false
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.opaque = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.opaque = false
    }

    override func drawRect(rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        
        UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7).setFill()
        UIRectFill(rect)
        
        //This is the same rect as the UIScrollView size 240 * 240, remains centered
        let circle = UIBezierPath(ovalInRect: CGRect(x: rect.size.width/2 - 240/2, y: rect.size.height/2 - 240/2, width: 240, height: 240))
        CGContextSetBlendMode(context, .Clear)
        UIColor.clearColor().setFill()
        circle.fill()
        
        //This is the same rect as the UIScrollView size 240 * 240, remains centered
        let square = UIBezierPath(rect: CGRect(x: rect.size.width/2 - 240/2, y: rect.size.height/2 - 240/2, width: 240, height: 240))
        UIColor.lightGrayColor().setStroke()
        square.lineWidth = 1.0
        CGContextSetBlendMode(context, .Normal)
        square.stroke()
        
    }

}
