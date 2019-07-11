//
//  Rotation.swift
//  Engine
//
//  Created by Tornike Gomareli on 7/11/19.
//  Copyright © 2019 Nick Lockwood. All rights reserved.
//


public struct Rotation {
    var m1,m2,m3,m4:Double
}


public extension Rotation {
    init(sine:Double, cosine:Double) {
        self.init(m1: cosine, m2: -sine, m3: sine, m4: cosine)
    }
}
