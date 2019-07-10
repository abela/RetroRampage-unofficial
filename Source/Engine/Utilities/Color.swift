//
//  Color.swift
//  Engine
//
//  Created by Tornike Gomareli on 7/9/19.
//  Copyright © 2019 Nick Lockwood. All rights reserved.
//

import Foundation

public struct Color {
    public var r:UInt8 //red
    public var g:UInt8 //green
    public var b:UInt8 //blue
    public var a:UInt8 //alpha
    
    
    public init(r: UInt8, g: UInt8, b: UInt8, a: UInt8 = 255) {
        self.r = r
        self.g = g
        self.b = b
        self.a = a
    }
}


public extension Color {
    static let clear = Color(r: 0, g: 0, b: 0, a: 0)
    static let black = Color(r: 0, g: 0, b: 0)
    static let white = Color(r: 255, g: 255, b: 255)
    static let gray = Color(r: 192, g: 192, b: 192)
    static let red = Color(r: 255, g: 0, b: 0)
    static let green = Color(r: 0, g: 255, b: 0)
    static let blue = Color(r: 0, g: 0, b: 255)
}
