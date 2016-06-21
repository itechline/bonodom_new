//
//  AddEstateViewController.swift
//  Bonodom
//
//  Created by Attila Dan on 13/06/16.
//  Copyright © 2016 Itechline. All rights reserved.
//

import UIKit
import SwiftyJSON

class AddEstateViewController: UIViewController {

    var items = [SpinnerModel]()
    var pickerData_hirdetes_tipus = [[String : String]]()
    var pickerData_butorozott = [[String : String]]()
    
    var pickerData_szobaszam = [[String : String]]()
    var pickerData_allapot = [[String : String]]()
    var pickerData_emelet = [[String : String]]()
    var pickerData_ing_tipus = [[String : String]]()
    var pickerData_erkely = [[String : String]]()
    var pickerData_parkolas = [[String : String]]()
    var pickerData_futes = [[String : String]]()
    var pickerData_lift = [[String : String]]()
    var pickerData_etan = [[String : String]]()
    var pickerData_kilatas = [[String : String]]()
    
    var szobaszam: String! = "0"
    var allapot: String! = "0"
    var emelet: String! = "0"
    var ing_tipus: String! = "0"
    var erkely: String! = "0"
    var parkolas: String! = "0"
    var futes: String! = "0"
    var lift: String! = "0"
    var etan: String! = "0"
    var kilatas: String! = "0"
    
    
    
    
    
    //FIRST PAGE
    @IBOutlet weak var hirdetes_cime_text: UITextField!
    @IBOutlet weak var hirdetes_leirasa_text: UITextField!
    @IBOutlet weak var ingatlan_ara_text: UITextField!
    @IBOutlet weak var varos_text: UITextField!
    @IBOutlet weak var utca_text: UITextField!
    @IBOutlet weak var hazszam_text: UITextField!
    @IBOutlet weak var meret_text: UITextField!
    
    var hirdetes_cime: String!
    var hirdetes_leirasa: String!
    var ingatlan_ara: String!
    var varos: String!
    var utca: String!
    var hazszam: String!
    var meret: String!
    var hirdetes_tipusa: String! = "0"
    var butorozott: String! = "0"
    
    @IBOutlet weak var hirdetes_tipusa_text: UIButton!
    @IBAction func hirdetes_tipusa_button(sender: AnyObject) {
        PickerDialog().show("Hirdetés típusa", options: pickerData_hirdetes_tipus, selected: "0") {
            (value, display) -> Void in
            self.hirdetes_tipusa_text.setTitle(display, forState: UIControlState.Normal)
            self.hirdetes_tipusa = value
            print("Unit selected: \(value)")
        }
    }
    
    @IBOutlet weak var butorozott_text: UIButton!
    @IBAction func butorozott_button(sender: AnyObject) {
        pickerData_butorozott = [
            ["value": "0", "display": "Nincs megadva"],
            ["value": "1", "display": "Igen"],
            ["value": "2", "display": "Nem"],
            ["value": "3", "display": "Alku tárgya"]
        ]
        
        PickerDialog().show("Bútor", options: pickerData_butorozott, selected: "0") {
            (value, display) -> Void in
            self.butorozott_text.setTitle(display, forState: UIControlState.Normal)
            self.butorozott = value
            print("Unit selected: \(value)")
        }
    }
    
    @IBAction func kovetkezo_1_button(sender: AnyObject) {
        var isFilled = true
        
        if (hirdetes_cime_text.text!.isEmpty) {
            isFilled = false
            hirdetes_cime_text.attributedPlaceholder = NSAttributedString(string:"*",
                                                                           attributes:[NSForegroundColorAttributeName: UIColor.redColor()])
        }
        
        if (hirdetes_leirasa_text.text!.isEmpty) {
            isFilled = false
            hirdetes_leirasa_text.attributedPlaceholder = NSAttributedString(string:"*",
                                                                          attributes:[NSForegroundColorAttributeName: UIColor.redColor()])
        }
        
        if (ingatlan_ara_text.text!.isEmpty) {
            isFilled = false
            ingatlan_ara_text.attributedPlaceholder = NSAttributedString(string:"*",
                                                                             attributes:[NSForegroundColorAttributeName: UIColor.redColor()])
        }
    
        if (varos_text.text!.isEmpty) {
            isFilled = false
            varos_text.attributedPlaceholder = NSAttributedString(string:"*",
                                                                         attributes:[NSForegroundColorAttributeName: UIColor.redColor()])
        }
        
        if (utca_text.text!.isEmpty) {
            isFilled = false
            utca_text.attributedPlaceholder = NSAttributedString(string:"*",
                                                                  attributes:[NSForegroundColorAttributeName: UIColor.redColor()])
        }
        
        if (hazszam_text.text!.isEmpty) {
            isFilled = false
            hazszam_text.attributedPlaceholder = NSAttributedString(string:"*",
                                                                 attributes:[NSForegroundColorAttributeName: UIColor.redColor()])
        }
        
        if (meret_text.text!.isEmpty) {
            isFilled = false
            meret_text.attributedPlaceholder = NSAttributedString(string:"*",
                                                                    attributes:[NSForegroundColorAttributeName: UIColor.redColor()])
        }
        
        if (hirdetes_tipusa == "" || hirdetes_tipusa == "0") {
            isFilled = false
        }
        
        if (butorozott == "" || butorozott == "0") {
            isFilled = false
        }
        
        if (isFilled) {
            hirdetes_cime = hirdetes_cime_text!.text!
            hirdetes_leirasa = hirdetes_leirasa_text!.text!
            ingatlan_ara = ingatlan_ara_text!.text!
            varos = varos_text!.text!
            utca = utca_text!.text!
            hazszam = hazszam_text!.text!
            meret = meret_text!.text!
            
            GetAddEstate.estate.append(AddEstateModel(cim: hirdetes_cime, varos: varos, utca: utca + hazszam, leiras: hirdetes_leirasa, ar: ingatlan_ara, meret: meret, etan: "", butor: "", kilatas: "", lift: "", futes: "", parkolas: "", erkely: "", tipus: "", emelet: "", allapot: "", szsz: "", lat: "", lng: "", e_type: "", zipcode: ""))
            
            
            //GetAddEstate.estate[0].cim.write(hirdetes_cime)
            //TODO: adatokat kimenteni mert nullázódnak view váltásnál
            let storyboard = UIStoryboard(name: "AddEstate", bundle: nil)
            let loginView = storyboard.instantiateViewControllerWithIdentifier("AddEstate_2")
            self.navigationController?.pushViewController(loginView, animated: true)
            //self.performSegueWithIdentifier("AddEstate_2", sender: nil)
        } else {
            let alert = UIAlertController(title: "HIBA", message: "Töltösön ki minden mezőt helyesen!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    //FIRST PAGE END
    
    
    //SECOND PAGE
    @IBOutlet weak var szobaszam_text: UIButton!
    @IBAction func szobaszam_button(sender: AnyObject) {
        PickerDialog().show("Szobaszám", options: pickerData_szobaszam, selected: "0") {
            (value, display) -> Void in
            self.szobaszam_text.setTitle(display, forState: UIControlState.Normal)
            self.szobaszam = value
            print("Unit selected: \(value)")
        }
    }
    
    @IBOutlet weak var allapot_text: UIButton!
    @IBAction func allapot_button(sender: AnyObject) {
        PickerDialog().show("Állapot", options: pickerData_allapot, selected: "0") {
            (value, display) -> Void in
            self.allapot_text.setTitle(display, forState: UIControlState.Normal)
            self.allapot = value
            print("Unit selected: \(value)")
        }
    }
    
    @IBOutlet weak var emelet_text: UIButton!
    @IBAction func emelet_button(sender: AnyObject) {
        PickerDialog().show("Emelet", options: pickerData_emelet, selected: "0") {
            (value, display) -> Void in
            self.emelet_text.setTitle(display, forState: UIControlState.Normal)
            self.emelet = value
            print("Unit selected: \(value)")
        }
    }
    
    @IBOutlet weak var ingatlan_tipus_text: UIButton!
    @IBAction func ingatlan_tipus_button(sender: AnyObject) {
        PickerDialog().show("Ingatlan típus", options: pickerData_ing_tipus, selected: "0") {
            (value, display) -> Void in
            self.ingatlan_tipus_text.setTitle(display, forState: UIControlState.Normal)
            self.ing_tipus = value
            print("Unit selected: \(value)")
        }
    }
    
    @IBOutlet weak var erkely_text: UIButton!
    @IBAction func erkely_button(sender: AnyObject) {
        PickerDialog().show("Erkély", options: pickerData_erkely, selected: "0") {
            (value, display) -> Void in
            self.erkely_text.setTitle(display, forState: UIControlState.Normal)
            self.erkely = value
            print("Unit selected: \(value)")
        }
    }
    
    @IBOutlet weak var parkolas_text: UIButton!
    @IBAction func parkolas_button(sender: AnyObject) {
        PickerDialog().show("Parkolás", options: pickerData_parkolas, selected: "0") {
            (value, display) -> Void in
            self.parkolas_text.setTitle(display, forState: UIControlState.Normal)
            self.parkolas = value
            print("Unit selected: \(value)")
        }
    }
    
    @IBOutlet weak var futes_text: UIButton!
    @IBAction func futes_button(sender: AnyObject) {
        PickerDialog().show("Fűtés", options: pickerData_futes, selected: "0") {
            (value, display) -> Void in
            self.futes_text.setTitle(display, forState: UIControlState.Normal)
            self.futes = value
            print("Unit selected: \(value)")
        }
    }
    
    @IBOutlet weak var lift_text: UIButton!
    @IBAction func lift_button(sender: AnyObject) {
        PickerDialog().show("Lift", options: pickerData_lift, selected: "0") {
            (value, display) -> Void in
            self.lift_text.setTitle(display, forState: UIControlState.Normal)
            self.lift = value
            print("Unit selected: \(value)")
        }
    }
    
    @IBOutlet weak var etan_text: UIButton!
    @IBAction func etan_button(sender: AnyObject) {
        PickerDialog().show("Energia tanusítvány", options: pickerData_etan, selected: "0") {
            (value, display) -> Void in
            self.etan_text.setTitle(display, forState: UIControlState.Normal)
            self.etan = value
            print("Unit selected: \(value)")
        }
    }
    
    @IBOutlet weak var kilatas_text: UIButton!
    @IBAction func kilatas_button(sender: AnyObject) {
        PickerDialog().show("Kilátás", options: pickerData_kilatas, selected: "0") {
            (value, display) -> Void in
            self.kilatas_text.setTitle(display, forState: UIControlState.Normal)
            self.kilatas = value
            print("Unit selected: \(value)")
        }
    }
    
    @IBAction func kovetkezo_2_button(sender: AnyObject) {
        GetAddEstate.estate.insert(AddEstateModel(cim: GetAddEstate.estate[0].cim, varos: GetAddEstate.estate[0].varos, utca: GetAddEstate.estate[0].utca, leiras: GetAddEstate.estate[0].leiras, ar: GetAddEstate.estate[0].ar, meret: GetAddEstate.estate[0].meret, etan: etan, butor: butorozott, kilatas: kilatas, lift: lift, futes: futes, parkolas: parkolas, erkely: erkely, tipus: ing_tipus, emelet: emelet, allapot: allapot, szsz: szobaszam, lat: "", lng: "", e_type: "", zipcode: ""), atIndex: 0)
        print (GetAddEstate.estate[0].cim)
        print (GetAddEstate.estate[0].emelet)
    }
    
    func loadSpinners() {
        SpinnerUtil.sharedInstance.get_list_ingatlanszoba{ (json: JSON) in
            self.items.removeAll()
            print ("SZOBASZAM")
            print (json)
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
        
        /*SpinnerUtil.sharedInstance.get_list_erkely{ (json: JSON) in
            self.items.removeAll()
            if let results = json.array {
                for entry in results {
                    self.items.append(SpinnerModel(json: entry, type: "erkely"))
                }
                
                for i in 0...self.items.count-1 {
                    if (i != 0) {
                        self.pickerData_erkely.append(["value": self.items[i].value, "display": self.items[i].display])
                    } else {
                        self.pickerData_erkely.append(["value": self.items[i].value, "display": "Nincs megadva"])
                    }
                }
            }
        }*/
        
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
        
        SpinnerUtil.sharedInstance.get_list_ingatlanfutes{ (json: JSON) in
            self.items.removeAll()
            if let results = json.array {
                for entry in results {
                    self.items.append(SpinnerModel(json: entry, type: "futestipus"))
                }
                
                for i in 0...self.items.count-1 {
                    if (i != 0) {
                        self.pickerData_futes.append(["value": self.items[i].value, "display": self.items[i].display])
                    } else {
                        self.pickerData_futes.append(["value": self.items[i].value, "display": "Nincs megadva"])
                    }
                }
            }
        }
        
        /*SpinnerUtil.sharedInstance.get_list_lift{ (json: JSON) in
            self.items.removeAll()
            if let results = json.array {
                for entry in results {
                    self.items.append(SpinnerModel(json: entry, type: "lift"))
                }
                
                for i in 0...self.items.count-1 {
                    if (i != 0) {
                        self.pickerData_lift.append(["value": self.items[i].value, "display": self.items[i].display])
                    } else {
                        self.pickerData_lift.append(["value": self.items[i].value, "display": "Nincs megadva"])
                    }
                }
            }
        }*/
        
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
        
        SpinnerUtil.sharedInstance.get_list_hirdetestipusa{ (json: JSON) in
            self.items.removeAll()
            if let results = json.array {
                for entry in results {
                    self.items.append(SpinnerModel(json: entry, type: "ing_e_type"))
                }
                
                for i in 0...self.items.count-1 {
                    if (i != 0) {
                        self.pickerData_hirdetes_tipus.append(["value": self.items[i].value, "display": self.items[i].display])
                    } else {
                        self.pickerData_hirdetes_tipus.append(["value": self.items[i].value, "display": "Nincs megadva"])
                    }
                }
            }
        }
    }
    
    //SECOND PAGE END
    
    
    
    @IBOutlet weak var KiemelImage: UIImageView!
    @IBOutlet weak var KiemelLabel: UILabel!
    @IBOutlet weak var KiemelLabelHint: UILabel!
    @IBOutlet weak var AddDescription: UITextField!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        loadSpinners()
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    
    @IBAction func KiemelSelector(sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            KiemelImage.hidden = false
            KiemelImage.image = UIImage(named: "kiemel_a")
            KiemelLabel.hidden = true
                    case 1:
            KiemelImage.hidden = false
            KiemelImage.image = UIImage(named: "kiemel_b")
            KiemelLabel.hidden = true
            
        case 2:
            KiemelImage.hidden = false
            KiemelImage.image = UIImage(named: "kiemel_c")
            KiemelLabel.hidden = true
           
        case 3:
            KiemelImage.hidden = true
            KiemelLabel.hidden = false
            
        default:
            KiemelImage.hidden = false
            KiemelImage.image = UIImage(named: "kiemel_a")
            KiemelLabel.hidden = true
            
        }
    }

}
