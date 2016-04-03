//
//  KACircleCropScrollView.swift
//  Circle Crop View Controller
//
//  Created by Keke Arif on 21/02/2016.
//  Copyright © 2016 Keke Arif. All rights reserved.
//

import UIKit

class KACircleCropScrollView: UIScrollView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = false
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.clipsToBounds = false
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        
    }

    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        
        let excessWidth = (UIScreen.mainScreen().bounds.size.width - self.bounds.size.width)/2
        let excessHeight = (UIScreen.mainScreen().bounds.size.height - self.bounds.size.height)/2
        
        if CGRectContainsPoint(CGRectInset(self.bounds, -excessWidth, -excessHeight), point) {
            return self
        }
        
        return nil
    }

}
