//
//  Rect.swift
//  Engine
//
//  Created by Tornike Gomareli on 7/10/19.
//  Copyright © 2019 Nick Lockwood. All rights reserved.
//

import Foundation


public struct Rect {
    var min, max: Vector
    
    public init(min:Vector, max:Vector) {
        self.min = min
        self.max = max
    }
}
