//
//  AgenciesViewController.swift
//  Bonodom
//
//  Created by Attila Dan on 03/06/16.
//  Copyright © 2016 Itechline. All rights reserved.
//

import UIKit
import GLKit


class AgenciesViewController: GLKViewController {

    var panoramaView = PanoramaView()
    
    override func viewDidLoad() {
        panoramaView.setImageWithName("living-room.jpg")
        panoramaView.touchToPan = false          // Use touch input to pan
        panoramaView.orientToDevice = true     // Use motion sensors to pan
        panoramaView.pinchToZoom = false         // Use pinch gesture to zoom
        panoramaView.showTouches = true         // Show touches
        self.view = panoramaView
    }
    
    override func glkView(view: GLKView, drawInRect rect: CGRect) {
        panoramaView.draw()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
