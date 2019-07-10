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
    mutating func draw(_ world: World) {
        let scale = Double(bitmap.height) / world.size.y
        
        // Draw player
        var rect = world.player.rect
        rect.min *= scale
        rect.max *= scale
        bitmap.fill(rect: rect, color: .blue)
    }
}
