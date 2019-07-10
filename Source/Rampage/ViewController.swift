//
//  ViewController.swift
//  Rampage
//
//  Created by Nick Lockwood on 17/05/2019.
//  Copyright © 2019 Nick Lockwood. All rights reserved.
//

import UIKit
import Engine

class ViewController: UIViewController {
    
    private let imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImageView()
        
        var bitmap = Bitmap(width: 8, height: 8, color: .white)
        bitmap[0,0] = .blue
        
        imageView.image = UIImage(bitmap: bitmap)
        
        //nearest-neighbor algorithm 
        imageView.layer.magnificationFilter = .nearest
    }
    
    func setupImageView() {
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
    }
}
