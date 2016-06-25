extension UIBezierPath {
    /**
     Creates an N-sided regular polygon within a given frame
     
     - precondition: withSides > 2
     
     - parameter createRegularShapeWithRect: the frame to draw the polygon
     - parameter withSides:                  the amound of sides of the polygon. Must be greater than 2.
     - parameter withRotation:               the degrees in radians to rotate the polygon
     
     - returns: the N-sided polygon
     */
    convenience init (createRegularShapeWithRect: CGRect, withSides: UInt = 3, withRotation: CGFloat? = nil) {
        self.init()
        //Checks to see if withSides meets the preconditions
        assert(withSides > 2, "withSides parameter must be greater than 3")
        
        //Moves the point to initial point to draw
        self.moveToPoint(CGPointMake(createRegularShapeWithRect.width/2 + createRegularShapeWithRect.midX, createRegularShapeWithRect.midY))
        
        //Creates end point the shape and draws it to there
        for i in 0..<withSides {
            let theta = CGFloat(2 * M_PI / Double(withSides) * Double(i))
            let x = createRegularShapeWithRect.midX + createRegularShapeWithRect.width/2 * cos(theta)
            let y = createRegularShapeWithRect.midY + createRegularShapeWithRect.height/2 * sin(theta)
            self.addLineToPoint(CGPointMake(x, y))
        }
        
        //If the rotation needs to
        self.transformPolygon(createRegularShapeWithRect, withRotation: withRotation)
        
        self.closePath()
    }
    
    /**
     Helper function to rotate the N-sided regular polygon. Used `applyTransform` and `CGAffineTransform`
     
     - parameter withRect:     the rect to rotate the polygon
     - parameter withRotation: the degrees in radians to rotate the polygon
     */
    private func transformPolygon(withRect: CGRect, withRotation: CGFloat?){
        //The transform settings
        if let rad = withRotation {
            let rotate = CGAffineTransformMakeRotation(rad)
            let offset = CGAffineTransformMakeTranslation(-withRect.width / 2, -withRect.height/2)
            let center = CGAffineTransformMakeTranslation(withRect.width/2, withRect.height/2)
        
            //First need to offset the polygon to (0,0)
            self.applyTransform(offset)
            //Rotates the polygon
            self.applyTransform(rotate)
            //Recenters the polygon back the the center of the rect
            self.applyTransform(center)
        }
    }
}
