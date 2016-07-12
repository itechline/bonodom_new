//
//  MapsViewController.swift
//  Bonodom
//
//  Created by Attila Dán on 2016. 07. 12..
//  Copyright © 2016. Itechline. All rights reserved.
//

import UIKit
import MapKit

class MapsViewController: UIViewController {

    @IBOutlet weak var maps: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBarItem()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
