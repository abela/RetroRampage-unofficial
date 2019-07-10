//
//  Player.swift
//  Engine
//
//  Created by Tornike Gomareli on 7/10/19.
//  Copyright © 2019 Nick Lockwood. All rights reserved.
//

import Foundation

public struct Player {
    public var position:Vector
    public var velocity:Vector
    public let radius:Double = 0.5
    
    public init(position:Vector) {
        self.position = position
        self.velocity = Vector(x:1, y:1)
    }
}

public extension Player {
    var rect: Rect {
        let halfSize = Vector(x: radius, y: radius)
        return Rect(min: position - halfSize, max: position + halfSize)
    }
}
