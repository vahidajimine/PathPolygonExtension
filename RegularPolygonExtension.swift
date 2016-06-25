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
     Creates an N-sided polygon within a given frame
     
     - precondition: withSides > 2 and `UIBezierPath.lineWidth` is pre-defined
     
     - parameter createPolygonInRect: the frame to draw the polygon
     - parameter withSides:                  the amound of sides of the polygon. Must be greater than 2.
     - parameter withRotation:               the degrees in radians to rotate the polygon
     - parameter withLineWidth:            the width of the `UIBezierPath.lineWidth` to adjust of drawn edges
     
     - returns: the N-sided polygon
     */
    convenience init (createPolygonInRect rect: CGRect, withSides sides: UInt = 3, withRotation rotation: CGFloat? = nil, withLineWidth width: CGFloat = 1.0) {
        self.init()
        //Checks to see if withSides meets the preconditions
        assert(sides > 2, "withSides parameter must be greater than 3")
        //Sets the line width to the given parameter. 1.0 is the default
        self.lineWidth = width
        //Calculate the radius if X and Y with the radius of the line width taken into account for proper drawing
        let xRad = rect.width/2 - self.lineWidth/2
        let yRad = rect.height/2 - self.lineWidth/2
        
        //Moves the point to initial point to draw
        self.moveToPoint(CGPointMake(xRad + rect.midX, rect.midY))
        
        //Calculates and draws a straight line to each vertex of the n-sided polygon
        for i in 0..<sides {
            let theta = CGFloat(2 * M_PI / Double(sides) * Double(i))
            let x = rect.midX + xRad * cos(theta)
            let y = rect.midY + yRad * sin(theta)
            self.addLineToPoint(CGPointMake(x, y))
        }
        
        //Rotate the polygon if needed
        self.transformPolygon(inRect: rect, withRotation: rotation)
        
        self.closePath()
    }
    
    /**
     Helper function to rotate the N-sided polygon. Used `applyTransform` and `CGAffineTransform`
     
     - parameter inRect:     the rect to rotate the polygon
     - parameter withRotation: the degrees in radians to rotate the polygon
     */
    private func transformPolygon(inRect rect: CGRect, withRotation rotation: CGFloat?){
        //The transform settings
        if let rad = rotation {
            //Calculate the transforms
            let rotate = CGAffineTransformMakeRotation(rad)
            let offset = CGAffineTransformMakeTranslation(-rect.width / 2 , -rect.height/2 )
            let center = CGAffineTransformMakeTranslation(rect.width/2 , rect.height/2)
        
            //Offsets the polygon to (0,0)
            self.applyTransform(offset)
            //Rotates the polygon
            self.applyTransform(rotate)
            //Recenters the polygon back the the center of the rect
            self.applyTransform(center)
        }
    }
}
