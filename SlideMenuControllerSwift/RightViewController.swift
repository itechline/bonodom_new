//
//  RightViewController.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 12/3/14.
//

import UIKit

class RightViewController : UIViewController {

 
    @IBAction func lift(sender: AnyObject) {
        print ("LIFT")
        let pickerData = [
            ["value": "0", "display": "Nincs Megadva"],
            ["value": "1", "display": "Van"],
            ["value": "2", "display": "Nincs"]
        ]
        
        
        PickerDialog().show("Distance units", options: pickerData, selected: "kilometer") {
            (value) -> Void in
            
            print("Unit selected: \(value)")
        }
    }
    
    @IBAction func teszt(sender: AnyObject) {
        print ("MITTUDOMÉN")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
