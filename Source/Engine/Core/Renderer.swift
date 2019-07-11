//
//  Renderer.swift
//  Engine
//
//  Created by Nick Lockwood on 02/06/2019.
//  Copyright © 2019 Nick Lockwood. All rights reserved.
//

public struct Renderer {
    public private(set) var bitmap: Bitmap

    public init(width: Int, height: Int) {
        self.bitmap = Bitmap(width: width, height: height, color: .black)
    }
}

public extension Renderer {
    mutating func draw(_ world: World) {
        let scale = Double(bitmap.height) / world.size.y

        drawMap(world, scale)
        
        drawPlayer(world, scale)
        
        
        castRays(world, scale)
        
        
        
        drawViewPlane(world, scale)
        
    }
    
    mutating private func drawMap(_ world:World, _ scale:Double) {
        for y in 0 ..< world.map.height {
            for x in 0 ..< world.map.width where world.map[x, y].isWall {
                let rect = Rect(
                    min: Vector(x: Double(x), y: Double(y)) * scale,
                    max: Vector(x: Double(x + 1), y: Double(y + 1)) * scale
                )
                bitmap.fill(rect: rect, color: .white)
            }
        }
    }
    
    mutating private func drawPlayer(_ world: World, _ scale: Double) {
        var rect = world.player.rect
        rect.min *= scale
        rect.max *= scale
        bitmap.fill(rect: rect, color: .blue)
    }
    
    
    mutating private func castRays(_ world:World, _ scale: Double) {
    
        // must refactor this method
        let columns = 10
        let viewWidth = 1.0
        let focalLength = 1.0
        let viewPlane = world.player.direction.orthogonal * viewWidth
        let step = viewPlane / Double(columns)
        let viewCenter = world.player.position + world.player.direction * focalLength
        let viewStart = viewCenter - viewPlane / 2

        var columnPosition = viewStart
        let rayDirection = columnPosition - world.player.position
        
        let viewPlaneDistance = rayDirection.length
        let ray = Ray(
            origin: world.player.position,
            direction: rayDirection / viewPlaneDistance
        )


        for _ in 0 ..< columns {
            let rayDirection = columnPosition - world.player.position
            let viewPlaneDistance = rayDirection.length
            let ray = Ray(
                origin: world.player.position,
                direction: rayDirection / viewPlaneDistance
            )
            let end = world.map.hitTest(ray: ray)
            bitmap.drawLine(from: ray.origin * scale, to: end * scale, color: .green)
            columnPosition += step
        }
    }
    
    mutating private func drawViewPlane(_ world:World, _ scale:Double) {
        let focalLength = 1.0
        let viewWidth = 1.0
        let viewPlane = world.player.direction.orthogonal * viewWidth
        let viewCenter = world.player.position + world.player.direction * focalLength
        let viewStart = viewCenter - viewPlane / 2
        let viewEnd = viewStart + viewPlane
        self.bitmap.drawLine(from: viewStart * scale, to: viewEnd * scale, color: .red)
    }
}
