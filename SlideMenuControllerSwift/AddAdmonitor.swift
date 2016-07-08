//
//  AddAdmonitor.swift
//  Bonodom
//
//  Created by Attila Dán on 2016. 07. 07..
//  Copyright © 2016. Itechline. All rights reserved.
//

import UIKit
import SwiftyJSON

class AddAdmonitor: UIViewController {
    var items = [SpinnerModel]()
    
    var kivitel_id = 0
    var szintek_min_id = 0
    var szintek_max_id = 0
    var szobaszam_min_id = 0
    var szobaszam_max_id = 0
    var lift_id = 0
    var erkely_id = 0
    var meret_id = 0
    var kilatas_id = 0
    var butorozott_id = 0
    var parkolas_id = 0
    var allapot_id = 0
    var etan_id = 0
    
    var pickerData_butorozott = [[String : String]]()
    
    var pickerData_szobaszam = [[String : String]]()
    var pickerData_allapot = [[String : String]]()
    var pickerData_emelet = [[String : String]]()
    var pickerData_ing_tipus = [[String : String]]()
    var pickerData_erkely = [[String : String]]()
    var pickerData_meret = [[String : String]]()
    var pickerData_parkolas = [[String : String]]()
    var pickerData_futes = [[String : String]]()
    var pickerData_lift = [[String : String]]()
    var pickerData_etan = [[String : String]]()
    var pickerData_kilatas = [[String : String]]()
    
    @IBOutlet weak var figyelo_neve: UITextField!
    @IBOutlet weak var kereses: UITextField!
    @IBOutlet weak var ar_min_text: UITextField!
    @IBOutlet weak var ar_max_text: UITextField!
    
    @IBOutlet weak var kivitel_text: UIButton!
    @IBAction func kivitel_button(sender: AnyObject) {
        self.dismissKeyboard()
        PickerDialog().show("Ingatlan típus", options: pickerData_ing_tipus, selected: "0") {
            (value, display) -> Void in
            self.kivitel_text.setTitle(display, forState: UIControlState.Normal)
            self.kivitel_id = Int(value)!
            print("Unit selected: \(value)")
        }
    }
    
    @IBOutlet weak var szintek_text: UIButton!
    @IBAction func szintek_button(sender: AnyObject) {
        self.dismissKeyboard()
        PickerDialog().show("Szintek Minimum", options: pickerData_emelet, selected: "0") {
            (value, display) -> Void in
            self.szintek_text.setTitle(display, forState: UIControlState.Normal)
            self.szintek_min_id = Int(value)!
            print("Unit selected: \(value)")
        }
    }
    
    @IBOutlet weak var szintek_max_text: UIButton!
    @IBAction func szintek_max_button(sender: AnyObject) {
        self.dismissKeyboard()
        PickerDialog().show("Szintek Maximum", options: pickerData_emelet, selected: "0") {
            (value, display) -> Void in
            self.szintek_max_text.setTitle(display, forState: UIControlState.Normal)
            self.szintek_max_id = Int(value)!
            print("Unit selected: \(value)")
        }
    }
    
    @IBOutlet weak var szobaszam_min_text: UIButton!
    @IBAction func szobaszam_min_button(sender: AnyObject) {
        self.dismissKeyboard()
        PickerDialog().show("Szobaszám Minimum", options: pickerData_szobaszam, selected: "0") {
            (value, display) -> Void in
            self.szobaszam_min_text.setTitle(display, forState: UIControlState.Normal)
            self.szobaszam_min_id = Int(value)!
            print("Unit selected: \(value)")
        }
    }
    
    @IBOutlet weak var szobaszam_max_text: UIButton!
    @IBAction func szobaszam_max_button(sender: AnyObject) {
        self.dismissKeyboard()
        PickerDialog().show("Szobaszám Minimum", options: pickerData_szobaszam, selected: "0") {
            (value, display) -> Void in
            self.szobaszam_max_text.setTitle(display, forState: UIControlState.Normal)
            self.szobaszam_max_id = Int(value)!
            print("Unit selected: \(value)")
        }
    }
    
    @IBOutlet weak var lift_text: UIButton!
    @IBAction func lift_button(sender: AnyObject) {
        self.dismissKeyboard()
        pickerData_lift = [
            ["value": "0", "display": "Nincs megadva"],
            ["value": "1", "display": "Van"],
            ["value": "2", "display": "Nincs"]
        ]
        
        PickerDialog().show("Lift", options: pickerData_lift, selected: "0") {
            (value, display) -> Void in
            self.lift_text.setTitle(display, forState: UIControlState.Normal)
            self.lift_id = Int(value)!
            print("Unit selected: \(value)")
        }
    }
    
    @IBOutlet weak var erkely_text: UIButton!
    @IBAction func erkely_button(sender: AnyObject) {
        self.dismissKeyboard()
        pickerData_erkely = [
            ["value": "0", "display": "Nincs megadva"],
            ["value": "1", "display": "Van"],
            ["value": "2", "display": "Nincs"]
        ]
        
        PickerDialog().show("Erkély", options: pickerData_erkely, selected: "0") {
            (value, display) -> Void in
            self.erkely_text.setTitle(display, forState: UIControlState.Normal)
            self.erkely_id = Int(value)!
            print("Unit selected: \(value)")
        }
    }
    
    @IBOutlet weak var meret_text: UIButton!
    @IBAction func meret_button(sender: AnyObject) {
        self.dismissKeyboard()
        pickerData_meret = [
            ["value": "0", "display": "Nincs megadva"],
            ["value": "1", "display": "25-ig"],
            ["value": "2", "display": "26-50"],
            ["value": "3", "display": "51-75"],
            ["value": "4", "display": "76_100"],
            ["value": "5", "display": "101-125"],
            ["value": "6", "display": "126-150"],
            ["value": "7", "display": "150+"]
        ]
        
        PickerDialog().show("Méret", options: pickerData_meret, selected: "0") {
            (value, display) -> Void in
            self.meret_text.setTitle(display, forState: UIControlState.Normal)
            self.meret_id = Int(value)!
            print("Unit selected: \(value)")
        }
    }
    
    @IBOutlet weak var kilatas_text: UIButton!
    @IBAction func kilatas_button(sender: AnyObject) {
        self.dismissKeyboard()
        PickerDialog().show("Kilátás", options: pickerData_kilatas, selected: "0") {
            (value, display) -> Void in
            self.kilatas_text.setTitle(display, forState: UIControlState.Normal)
            self.kilatas_id = Int(value)!
            print("Unit selected: \(value)")
        }
    }
    
    @IBOutlet weak var butorozott_text: UIButton!
    @IBAction func butorozott_button(sender: AnyObject) {
        self.dismissKeyboard()
        pickerData_butorozott = [
            ["value": "0", "display": "Nincs megadva"],
            ["value": "1", "display": "Nem"],
            ["value": "2", "display": "Igen"],
            ["value": "3", "display": "Alku tárgya"]
        ]
        
        PickerDialog().show("Bútor", options: pickerData_butorozott, selected: "0") {
            (value, display) -> Void in
            self.butorozott_text.setTitle(display, forState: UIControlState.Normal)
            self.butorozott_id = Int(value)!
            print("Unit selected: \(value)")
        }
    }
    
    @IBOutlet weak var parkolas_text: UIButton!
    @IBAction func parkolas_button(sender: AnyObject) {
        self.dismissKeyboard()
        PickerDialog().show("Parkolás", options: pickerData_parkolas, selected: "0") {
            (value, display) -> Void in
            self.parkolas_text.setTitle(display, forState: UIControlState.Normal)
            self.parkolas_id = Int(value)!
            print("Unit selected: \(value)")
        }
    }
    
    @IBOutlet weak var allapot_text: UIButton!
    @IBAction func allapot_button(sender: AnyObject) {
        self.dismissKeyboard()
        PickerDialog().show("Állapot", options: pickerData_allapot, selected: "0") {
            (value, display) -> Void in
            self.allapot_text.setTitle(display, forState: UIControlState.Normal)
            self.allapot_id = Int(value)!
            print("Unit selected: \(value)")
        }
    }
    
    @IBOutlet weak var etan_text: UIButton!
    @IBAction func etan_button(sender: AnyObject) {
        self.dismissKeyboard()
        PickerDialog().show("Energia tanusítvány", options: pickerData_etan, selected: "0") {
            (value, display) -> Void in
            self.etan_text.setTitle(display, forState: UIControlState.Normal)
            self.etan_id = Int(value)!
            print("Unit selected: \(value)")
        }
    }
    
    
    
    
    @IBAction func save_admonitor_button(sender: AnyObject) {
        self.dismissKeyboard()
        let name : String = figyelo_neve!.text!
        let search : String = kereses!.text!
        let ar_min : String = ar_min_text!.text!
        let ar_max : String = ar_max_text!.text!
        
        
        AdMonitorUtil.sharedInstance.add_admonitor(name, butor: String(butorozott_id), lift: String(lift_id), erkely: String(erkely_id), meret: String(meret_id), szsz_max: String(szobaszam_max_id), szsz_min: String(szobaszam_min_id), emelet_max: String(szintek_max_id), emelet_min: String(szintek_min_id), tipus_id: kivitel_id, allapot_id: allapot_id, energia_id: etan_id, kilatas_id: kilatas_id, parkolas: parkolas_id, ar_min: ar_min, ar_max: ar_max, kulcsszo: search, onCompletion: { (json: JSON) in
            print (json)
            var err: Bool!
            err = json["error"].boolValue
            if (!err) {
                dispatch_async(dispatch_get_main_queue(),{
                    //viewController.dismissViewControllerAnimated(true, completion: nil)
                    self.navigationController?.popViewControllerAnimated(true);
                })
            }
        })
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        loadSpinners()
        // Do view setup here.
    }
    
    func loadSpinners() {
        SpinnerUtil.sharedInstance.get_list_ingatlantipus{ (json: JSON) in
            self.items.removeAll()
            if let results = json.array {
                for entry in results {
                    self.items.append(SpinnerModel(json: entry, type: "tipus"))
                }
                
                for i in 0...self.items.count-1 {
                    if (i != 0) {
                        self.pickerData_ing_tipus.append(["value": self.items[i].value, "display": self.items[i].display])
                    } else {
                        self.pickerData_ing_tipus.append(["value": self.items[i].value, "display": "Nincs megadva"])
                    }
                }
            }
        }
        
        SpinnerUtil.sharedInstance.get_list_ingatlanemelet{ (json: JSON) in
            self.items.removeAll()
            if let results = json.array {
                for entry in results {
                    self.items.append(SpinnerModel(json: entry, type: "emelet"))
                }
                
                for i in 0...self.items.count-1 {
                    if (i != 0) {
                        self.pickerData_emelet.append(["value": self.items[i].value, "display": self.items[i].display])
                    } else {
                        self.pickerData_emelet.append(["value": self.items[i].value, "display": "Nincs megadva"])
                    }
                }
            }
        }
        
        SpinnerUtil.sharedInstance.get_list_ingatlanszoba{ (json: JSON) in
            self.items.removeAll()
            if let results = json.array {
                for entry in results {
                    self.items.append(SpinnerModel(json: entry, type: "szsz"))
                }
                
                for i in 0...self.items.count-1 {
                    if (i != 0) {
                        self.pickerData_szobaszam.append(["value": self.items[i].value, "display": self.items[i].display])
                    } else {
                        self.pickerData_szobaszam.append(["value": self.items[i].value, "display": "Nincs megadva"])
                    }
                }
            }
        }
        
        SpinnerUtil.sharedInstance.get_list_ingatlankilatas{ (json: JSON) in
            self.items.removeAll()
            if let results = json.array {
                for entry in results {
                    self.items.append(SpinnerModel(json: entry, type: "kilatas"))
                }
                
                for i in 0...self.items.count-1 {
                    if (i != 0) {
                        self.pickerData_kilatas.append(["value": self.items[i].value, "display": self.items[i].display])
                    } else {
                        self.pickerData_kilatas.append(["value": self.items[i].value, "display": "Nincs megadva"])
                    }
                }
            }
        }
        
        SpinnerUtil.sharedInstance.get_list_ingatlanparkolas{ (json: JSON) in
            self.items.removeAll()
            if let results = json.array {
                for entry in results {
                    self.items.append(SpinnerModel(json: entry, type: "parkolas"))
                }
                
                for i in 0...self.items.count-1 {
                    if (i != 0) {
                        self.pickerData_parkolas.append(["value": self.items[i].value, "display": self.items[i].display])
                    } else {
                        self.pickerData_parkolas.append(["value": self.items[i].value, "display": "Nincs megadva"])
                    }
                }
            }
        }
        
        SpinnerUtil.sharedInstance.get_list_ingatlanallapota{ (json: JSON) in
            self.items.removeAll()
            if let results = json.array {
                for entry in results {
                    self.items.append(SpinnerModel(json: entry, type: "allapot"))
                }
                
                for i in 0...self.items.count-1 {
                    if (i != 0) {
                        self.pickerData_allapot.append(["value": self.items[i].value, "display": self.items[i].display])
                    } else {
                        self.pickerData_allapot.append(["value": self.items[i].value, "display": "Nincs megadva"])
                    }
                }
            }
        }
        
        SpinnerUtil.sharedInstance.get_list_ingatlanenergia{ (json: JSON) in
            self.items.removeAll()
            if let results = json.array {
                for entry in results {
                    self.items.append(SpinnerModel(json: entry, type: "etan"))
                }
                
                for i in 0...self.items.count-1 {
                    if (i != 0) {
                        self.pickerData_etan.append(["value": self.items[i].value, "display": self.items[i].display])
                    } else {
                        self.pickerData_etan.append(["value": self.items[i].value, "display": "Nincs megadva"])
                    }
                }
            }
        }
    }
    
}
