//
//  RightViewController.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 12/3/14.
//

import UIKit
import SwiftyJSON

class RightViewController : UIViewController {

 
    var type_items = [SpinnerModel]()
    var pickerData_type = [[String : String]]()
    var pickerData_lift = [[String : String]]()
    var pickerData_etan = [[String : String]]()
    var pickerData_allapot = [[String : String]]()
    var pickerData_parkolas = [[String : String]]()
    var pickerData_kilatas = [[String : String]]()
    
    @IBOutlet weak var liftText: UIButton!
    @IBAction func lift(sender: AnyObject) {
        print ("LIFT")
        pickerData_lift = [
            ["value": "0", "display": "Mindegy"],
            ["value": "1", "display": "Van"],
            ["value": "2", "display": "Nincs"]
        ]
        
        PickerDialog().show("Lift", options: pickerData_lift, selected: "0") {
            (value, display) -> Void in
            self.liftText.setTitle(display, forState: UIControlState.Normal)
            print("Unit selected: \(value)")
        }
    }
    
    @IBOutlet weak var kivitelText: UIButton!
    @IBAction func teszt(sender: AnyObject) {
        PickerDialog().show("Kivitel", options: pickerData_type, selected: "0") {
            (value, display) -> Void in
            self.kivitelText.setTitle(display, forState: UIControlState.Normal)
            print("Unit selected: \(value)")
        }
    }
    
    
    @IBOutlet weak var etanText: UIButton!
    @IBAction func etan(sender: AnyObject) {
        PickerDialog().show("Energiatanusítvány", options: pickerData_etan, selected: "0") {
            (value, display) -> Void in
            self.etanText.setTitle(display, forState: UIControlState.Normal)
            print("Unit selected: \(value)")
        }
    }
    
    
    @IBOutlet weak var allapotText: UIButton!
    @IBAction func allapot(sender: AnyObject) {
        PickerDialog().show("Állapot", options: pickerData_allapot, selected: "0") {
            (value, display) -> Void in
            self.allapotText.setTitle(display, forState: UIControlState.Normal)
            print("Unit selected: \(value)")
        }
    }
    
    
    @IBOutlet weak var parkolasText: UIButton!
    @IBAction func parkolas(sender: AnyObject) {
        PickerDialog().show("Parkolás", options: pickerData_parkolas, selected: "0") {
            (value, display) -> Void in
            self.parkolasText.setTitle(display, forState: UIControlState.Normal)
            print("Unit selected: \(value)")
        }
    }
    
    
    
    @IBOutlet weak var kilatasText: UIButton!
    @IBAction func kilatas(sender: AnyObject) {
        PickerDialog().show("Kilátás", options: pickerData_kilatas, selected: "0") {
            (value, display) -> Void in
            self.kilatasText.setTitle(display, forState: UIControlState.Normal)
            print("Unit selected: \(value)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SpinnerUtil.sharedInstance.get_list_ingatlantipus{ (json: JSON) in
            self.type_items.removeAll()
            if let results = json.array {
                for entry in results {
                    self.type_items.append(SpinnerModel(json: entry, type: "tipus"))
                }
                
                for i in 0...self.type_items.count-1 {
                    self.pickerData_type.append(["value": self.type_items[i].value, "display": self.type_items[i].display])
                }
            }
        }
        
        SpinnerUtil.sharedInstance.get_list_ingatlanenergia{ (json: JSON) in
            self.type_items.removeAll()
            if let results = json.array {
                for entry in results {
                    self.type_items.append(SpinnerModel(json: entry, type: "etan"))
                }
                
                for i in 0...self.type_items.count-1 {
                    self.pickerData_etan.append(["value": self.type_items[i].value, "display": self.type_items[i].display])
                }
            }
        }
        
        SpinnerUtil.sharedInstance.get_list_ingatlanallapota{ (json: JSON) in
            print ("ALLAPOT")
            print (json)
            self.type_items.removeAll()
            if let results = json.array {
                for entry in results {
                    self.type_items.append(SpinnerModel(json: entry, type: "allapot"))
                }
                
                for i in 0...self.type_items.count-1 {
                    self.pickerData_allapot.append(["value": self.type_items[i].value, "display": self.type_items[i].display])
                }
            }
        }
        
        SpinnerUtil.sharedInstance.get_list_ingatlanparkolas{ (json: JSON) in
            self.type_items.removeAll()
            if let results = json.array {
                for entry in results {
                    self.type_items.append(SpinnerModel(json: entry, type: "parkolas"))
                }
                
                for i in 0...self.type_items.count-1 {
                    self.pickerData_parkolas.append(["value": self.type_items[i].value, "display": self.type_items[i].display])
                }
            }
        }
        
        SpinnerUtil.sharedInstance.get_list_ingatlankilatas{ (json: JSON) in
            print ("KILÁTÁS")
            print (json)
            self.type_items.removeAll()
            if let results = json.array {
                for entry in results {
                    self.type_items.append(SpinnerModel(json: entry, type: "kilatas"))
                }
                
                for i in 0...self.type_items.count-1 {
                    self.pickerData_kilatas.append(["value": self.type_items[i].value, "display": self.type_items[i].display])
                }
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
