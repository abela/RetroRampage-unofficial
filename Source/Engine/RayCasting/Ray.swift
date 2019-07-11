//
//  Ray.swift
//  Engine
//
//  Created by Tornike Gomareli on 7/10/19.
//  Copyright © 2019 Nick Lockwood. All rights reserved.
//


public struct Ray {
    public var origin,direction:Vector
    
    public init(origin:Vector, direction:Vector){
        self.origin = origin
        self.direction = direction
    }
}
