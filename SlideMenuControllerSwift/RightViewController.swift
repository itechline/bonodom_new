//
//  RightViewController.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 12/3/14.
//

import UIKit
import SwiftyJSON

class RightViewController : UIViewController {
 
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
    
    var items = [SpinnerModel]()
    var admonitor_item = [AdmonitorModel]()
    
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
    
    @IBOutlet weak var keyword_text: UITextField!
    @IBOutlet weak var min_price_text: UITextField!
    @IBOutlet weak var max_price_text: UITextField!
    
    @IBOutlet weak var szintek_min_text: UIButton!
    @IBAction func szintek_min_button(sender: AnyObject) {
        self.dismissKeyboard()
        PickerDialog().show("Szintek Minimum", options: pickerData_emelet, selected: "0") {
            (value, display) -> Void in
            self.szintek_min_text.setTitle(display, forState: UIControlState.Normal)
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
    
    @IBOutlet weak var szsz_min_text: UIButton!
    @IBAction func szsz_min_button(sender: AnyObject) {
        self.dismissKeyboard()
        PickerDialog().show("Szobaszám Minimum", options: pickerData_szobaszam, selected: "0") {
            (value, display) -> Void in
            self.szsz_min_text.setTitle(display, forState: UIControlState.Normal)
            self.szobaszam_min_id = Int(value)!
            print("Unit selected: \(value)")
        }
    }
    
    @IBOutlet weak var szsz_max_text: UIButton!
    @IBAction func szsz_max_button(sender: AnyObject) {
        self.dismissKeyboard()
        PickerDialog().show("Szobaszám Minimum", options: pickerData_szobaszam, selected: "0") {
            (value, display) -> Void in
            self.szsz_max_text.setTitle(display, forState: UIControlState.Normal)
            self.szobaszam_max_id = Int(value)!
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
    
    
    
    
    @IBOutlet weak var liftText: UIButton!
    @IBAction func lift(sender: AnyObject) {
        self.dismissKeyboard()
        pickerData_lift = [
            ["value": "0", "display": "Mindegy"],
            ["value": "1", "display": "Van"],
            ["value": "2", "display": "Nincs"]
        ]
        
        PickerDialog().show("Lift", options: pickerData_lift, selected: "0") {
            (value, display) -> Void in
            self.liftText.setTitle(display, forState: UIControlState.Normal)
            self.lift_id = Int(value)!
            print("Unit selected: \(value)")
        }
    }
    
    @IBOutlet weak var kivitelText: UIButton!
    @IBAction func teszt(sender: AnyObject) {
        self.dismissKeyboard()
        PickerDialog().show("Kivitel", options: pickerData_ing_tipus, selected: "0") {
            (value, display) -> Void in
            self.kivitelText.setTitle(display, forState: UIControlState.Normal)
            self.kivitel_id = Int(value)!
            print("Unit selected: \(value)")
        }
    }
    
    
    @IBOutlet weak var etanText: UIButton!
    @IBAction func etan(sender: AnyObject) {
        self.dismissKeyboard()
        PickerDialog().show("Energiatanusítvány", options: pickerData_etan, selected: "0") {
            (value, display) -> Void in
            self.etanText.setTitle(display, forState: UIControlState.Normal)
            self.etan_id = Int(value)!
            print("Unit selected: \(value)")
        }
    }
    
    
    @IBOutlet weak var allapotText: UIButton!
    @IBAction func allapot(sender: AnyObject) {
        self.dismissKeyboard()
        PickerDialog().show("Állapot", options: pickerData_allapot, selected: "0") {
            (value, display) -> Void in
            self.allapotText.setTitle(display, forState: UIControlState.Normal)
            self.allapot_id = Int(value)!
            print("Unit selected: \(value)")
        }
    }
    
    
    @IBOutlet weak var parkolasText: UIButton!
    @IBAction func parkolas(sender: AnyObject) {
        self.dismissKeyboard()
        PickerDialog().show("Parkolás", options: pickerData_parkolas, selected: "0") {
            (value, display) -> Void in
            self.parkolasText.setTitle(display, forState: UIControlState.Normal)
            self.parkolas_id = Int(value)!
            print("Unit selected: \(value)")
        }
    }
    
    
    
    @IBOutlet weak var kilatasText: UIButton!
    @IBAction func kilatas(sender: AnyObject) {
        self.dismissKeyboard()
        PickerDialog().show("Kilátás", options: pickerData_kilatas, selected: "0") {
            (value, display) -> Void in
            self.kilatasText.setTitle(display, forState: UIControlState.Normal)
            self.kilatas_id = Int(value)!
            print("Unit selected: \(value)")
        }
    }
    
    @IBAction func search_button(sender: AnyObject) {
        self.dismissKeyboard()
        let search : String = keyword_text!.text!
        let ar_min : String = min_price_text!.text!
        let ar_max : String = max_price_text!.text!
        
        admonitor_item.append(AdmonitorModel(json: nil))
    
        admonitor_item[0].keyword = search
        admonitor_item[0].ingatlan_ar_max = ar_max
        admonitor_item[0].ingatlan_ar_min = ar_min
        admonitor_item[0].ingatlan_allapot_id = allapot_id
        admonitor_item[0].ingatlan_parkolas_id = parkolas_id
        admonitor_item[0].ingatlan_tipus_id = kivitel_id
        admonitor_item[0].ingatlan_emelet_min = szintek_min_id
        admonitor_item[0].ingatlan_emelet_max = szintek_max_id
        admonitor_item[0].ingatlan_szsz_max = szobaszam_max_id
        admonitor_item[0].ingatlan_szsz_min = szobaszam_min_id
        admonitor_item[0].ingatlan_lift = lift_id
        admonitor_item[0].ingatlan_erkely = erkely_id
        admonitor_item[0].ingatlan_meret = meret_id
        admonitor_item[0].ingatlan_kilatas_id = kilatas_id
        admonitor_item[0].ingatlan_butorozott = butorozott_id
        admonitor_item[0].ingatlan_energiatan_id = etan_id
        
        /*
         butor_post = admonitor_model[admonitor_id].ingatlan_butorozott
         lift_post = admonitor_model[admonitor_id].ingatlan_lift
         erkely_post = admonitor_model[admonitor_id].ingatlan_erkely
         meret_post = admonitor_model[admonitor_id].ingatlan_meret
         szoba_min_post = admonitor_model[admonitor_id].ingatlan_szsz_min
         szoba_max_post = admonitor_model[admonitor_id].ingatlan_szsz_max
         emelet_min_post = admonitor_model[admonitor_id].ingatlan_emelet_min
         emelet_max_post = admonitor_model[admonitor_id].ingatlan_emelet_max
         tipus_post = admonitor_model[admonitor_id].ingatlan_tipus_id
         allapot_post = admonitor_model[admonitor_id].ingatlan_allapot_id
         etan_post = admonitor_model[admonitor_id].ingatlan_energiatan_id
         kilatas_post = admonitor_model[admonitor_id].ingatlan_kilatas_id
         ar_max_post = admonitor_model[admonitor_id].ingatlan_ar_max
         ar_min_post = admonitor_model[admonitor_id].ingatlan_ar_min
         keyword_post = admonitor_model[admonitor_id].keyword
         parkolas_post = admonitor_model[admonitor_id].ingatlan_parkolas_id
 */
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let main = storyboard.instantiateViewControllerWithIdentifier("MainViewController") as! MainViewController
        main.admonitor_model = admonitor_item
        main.admonitor_id = 0
        main.isAdmonitor = true
        //self.navigationController?.pushViewController(main, animated: true)
        
        NSNotificationCenter.defaultCenter().postNotificationName("changeToMain", object: nil)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSpinners()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
