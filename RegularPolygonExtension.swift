//
//  RegularPolygonExtension.swift
//
//  Created by Vahid Ajimine on 6/24/16.
//  Copyright © 2016 Vahid Ajimine. All rights reserved.
//

import Foundation
import UIKit

extension UIBezierPath {
    /**
     Creates an N-sided regular polygon within a given frame
     
     - precondition: withSides > 2
     
     - parameter createRegularShapeWithRect: the frame to draw the polygon
     - parameter withSides:                  the amound of sides of the polygon. Must be greater than 2.
     - parameter withRotation:               the degrees in radians to rotate the polygon
     
     - returns: the N-sided polygon
     */
    convenience init (createRegularShape rect: CGRect, withSides sides: UInt = 3, withRotation rotation: CGFloat? = nil, customLineWidth width: CGFloat = 1.0) {
        self.init()
        //Checks to see if withSides meets the preconditions
        assert(sides > 2, "withSides parameter must be greater than 3")
        self.lineWidth = width
        
        let xRad = rect.width/2 - self.lineWidth/2
        let yRad = rect.height/2 - self.lineWidth/2
        
        //Moves the point to initial point to draw
        self.moveToPoint(CGPointMake(xRad + rect.midX, rect.midY))
        
        //Creates end point the shape and draws it to there
        for i in 0..<sides {
            let theta = CGFloat(2 * M_PI / Double(sides) * Double(i))
            let x = rect.midX + xRad * cos(theta)
            let y = rect.midY + yRad * sin(theta)
            self.addLineToPoint(CGPointMake(x, y))
        }
        
        //If the rotation needs to
        self.transformPolygon(withRect: rect, withRotation: rotation)
        
        self.closePath()
    }
    
    /**
     Helper function to rotate the N-sided regular polygon. Used `applyTransform` and `CGAffineTransform`
     
     - parameter withRect:     the rect to rotate the polygon
     - parameter withRotation: the degrees in radians to rotate the polygon
     */
    private func transformPolygon(withRect rect: CGRect, withRotation rotation: CGFloat?){
        //The transform settings
        if let rad = rotation {
            let rotate = CGAffineTransformMakeRotation(rad)
            let offset = CGAffineTransformMakeTranslation(-rect.width / 2 , -rect.height/2 )
            let center = CGAffineTransformMakeTranslation(rect.width/2 , rect.height/2)
        
            //First need to offset the polygon to (0,0)
            self.applyTransform(offset)
            //Rotates the polygon
            self.applyTransform(rotate)
            //Recenters the polygon back the the center of the rect
            self.applyTransform(center)
        }
    }
}
