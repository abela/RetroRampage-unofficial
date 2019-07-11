//
//  ViewController.swift
//  Rampage
//
//  Created by Nick Lockwood on 17/05/2019.
//  Copyright © 2019 Nick Lockwood. All rights reserved.
//


import UIKit
import Engine

// viewController need refactoring

private let joystickRadius: Double = 40
private let maximumTimeStep: Double = 1 / 20
private let worldTimeStep: Double = 1 / 120

private func loadMap() -> Tilemap {
    let jsonURL = Bundle.main.url(forResource: "Map", withExtension: "geojson")!
    let jsonData = try! Data(contentsOf: jsonURL)
    return try! JSONDecoder().decode(Tilemap.self, from: jsonData)
}

class ViewController: UIViewController {
    private let imageView = UIImageView()
    private let panGesture = UIPanGestureRecognizer()
    private var world = World(map: loadMap())
    private var lastFrameTime = CACurrentMediaTime()
    private var fpsLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpImageView()
        
        fpsLabel.frame = CGRect(x: 25, y: 25, width: 200, height: 50)
        fpsLabel.textColor = .white
        
        fpsLabel.text = "123"
        
        self.view.addSubview(fpsLabel)
        let displayLink = CADisplayLink(target: self, selector: #selector(update))
        displayLink.add(to: .main, forMode: .common)
        
        view.addGestureRecognizer(panGesture)
    }
    
    private var inputVector: Vector {
        switch panGesture.state {
        case .began, .changed:
            let translation = panGesture.translation(in: view)
            var vector = Vector(x: Double(translation.x), y: Double(translation.y))
            vector /= max(joystickRadius, vector.length)
            panGesture.setTranslation(CGPoint(
                x: vector.x * joystickRadius,
                y: vector.y * joystickRadius
            ), in: view)
            return vector
        default:
            return Vector(x: 0, y: 0)
        }
    }
    
    
    // need to refactor this method
    @objc func update(_ displayLink: CADisplayLink) {
        let timeStep = min(maximumTimeStep, displayLink.timestamp - lastFrameTime)
        
        calculateFramePerSecond(displayLink)
        
        // making some trigonometry in platform layer
        let inputVector = self.inputVector
        let rotation = inputVector.x * world.player.turningSpeed * worldTimeStep
        let input = Input(
            speed: -inputVector.y,
            rotation: Rotation(sine: sin(rotation), cosine: cos(rotation))
        )
        
        let worldSteps = (timeStep / worldTimeStep).rounded(.up)
        for _ in 0 ..< Int(worldSteps) {
            world.update(timeStep: timeStep / worldSteps, input: input)
        }
        lastFrameTime = displayLink.timestamp
        
        let width = Int(imageView.bounds.width), height = Int(imageView.bounds.height)
        var renderer = Renderer(width: width, height: height)
        renderer.draw(world)
        
        imageView.image = UIImage(bitmap: renderer.bitmap)
    }
    
    func calculateFramePerSecond(_ displayLink: CADisplayLink){
        var retVal : Int = 60
        
         retVal = Int(round(1000 / displayLink.duration)/1000)
        
        
        fpsLabel.text = "Current game Fps : \(retVal)"
    }
    
    func setUpImageView() {
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
        imageView.layer.magnificationFilter = .nearest
    }
}
