//
//  Renderer.swift
//  Engine
//
//  Created by Tornike Gomareli on 7/10/19.
//  Copyright © 2019 Nick Lockwood. All rights reserved.
//

import Foundation

public struct Renderer {
    public private(set) var bitmap: Bitmap
    
    public init(width: Int, height: Int) {
        self.bitmap = Bitmap(width: width, height: height, color: .white)
    }
}

public extension Renderer {
    mutating func draw() {
        bitmap[0, 0] = .blue
    }
}
