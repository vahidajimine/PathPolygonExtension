# UIBezierPath Polygon Extention
Extends UIBezierPath to add the ability to draw a N-sided polygon with rotation capabilities. You can also specify the line width of the path

# Interface file
```Swift
extension UIBezierPath {
    /**
     Creates an N-sided polygon within a given frame
     
     - precondition: withSides > 2 and `UIBezierPath.lineWidth` is pre-defined
     
     - parameter createPolygonInRect: the frame to draw the polygon
     - parameter withSides:           the amound of sides of the polygon. Must be greater than 2.
     - parameter withRotation:        the degrees in radians to rotate the polygon
     - parameter withLineWidth:       the width of the `UIBezierPath.lineWidth` to adjust of drawn edges
     
     - returns: the N-sided polygon
     */
    convenience internal init(createPolygonInRect rect: CGRect, withSides sides: UInt = default, withRotation rotation: CGFloat? = default, withLineWidth width: CGFloat = default)
}

```
