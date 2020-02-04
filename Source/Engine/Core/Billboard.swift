//
//  Billboard.swift
//  Engine
//
//  Created by Tornike Gomareli on 2/4/20.
//  Copyright © 2020 Nick Lockwood. All rights reserved.
//

import Foundation

public struct BillBoard {
    public var start: Vector
    public var direction: Vector
    public var length: Double
    
    public init(start: Vector, direction: Vector, length: Double) {
           self.start = start
           self.direction = direction
           self.length = length
       }
}

public extension BillBoard {
    var end: Vector {
        return start + direction * length
    }
    
    
    func hitTest(_ ray: Ray) -> Vector? {
        var lhs = ray, rhs = Ray(origin: start, direction: direction)

        // Ensure rays are never exactly vertical
        let epsilon = 0.00001
        if abs(lhs.direction.x) < epsilon {
            lhs.direction.x = epsilon
        }
        if abs(rhs.direction.x) < epsilon {
            rhs.direction.x = epsilon
        }

        // Calculate slopes and intercepts
        let (slope1, intercept1) = lhs.slopeIntercept
        let (slope2, intercept2) = rhs.slopeIntercept

        // Check if slopes are parallel
        if slope1 == slope2 {
            return nil
        }

        // Find intersection point
        let x = (intercept1 - intercept2) / (slope2 - slope1)
        let y = slope1 * x + intercept1
        
        // Check intersection point is in range
        let distanceAlongRay = (x - lhs.origin.x) / lhs.direction.x
        if distanceAlongRay < 0 {
            return nil
        }

        let distanceAlongBillboard = (x - rhs.origin.x) / rhs.direction.x
        if distanceAlongBillboard < 0 || distanceAlongBillboard > length {
            return nil
        }
        
        return Vector(x: x, y: y)
    }
}
