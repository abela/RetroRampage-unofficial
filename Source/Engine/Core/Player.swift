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
    
    public init(position:Vector) {
        self.position = position
        self.velocity = Vector(x:1, y:1)
    }
}


public extension Player {
    mutating func update(timeStep: Double) {
        position += velocity * timeStep
        position.x.formTruncatingRemainder(dividingBy: 8)
        position.y.formTruncatingRemainder(dividingBy: 8)
    }
}
