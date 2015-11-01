//
//  SlantedView.swift
//  Groups
//
//  Created by Aditya Chugh on 2015-03-22.
//  Copyright (c) 2015 Aditya Chugh. All rights reserved.
//

import UIKit

@IBDesignable

class SlantedView: UIView {
    
    override func drawRect(rect: CGRect) {
        
        backgroundColor = UIColor.clearColor()
        
        let backgroundPath = UIBezierPath(rect: rect)
        
        UIColor.PrimaryColor().setFill()
        
        backgroundPath.fill()
        
        self.backgroundColor = UIColor.clearColor()
        
        let path = UIBezierPath()
        path.moveToPoint(CGPointMake(0, 0))
        path.addLineToPoint(CGPointMake(0, rect.height))
        path.addLineToPoint(CGPointMake(rect.width, rect.height))
        path.addLineToPoint(CGPointMake(rect.width, 100))
        path.closePath()
        
        UIColor.whiteColor().setFill()
        
        path.fill()
    }
}
