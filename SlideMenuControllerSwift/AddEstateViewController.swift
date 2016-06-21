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
    var hirdetes_tipusa: String!
    var butorozott: String!
    
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
        
        if (isFilled) {
            hirdetes_cime = hirdetes_cime_text!.text!
            hirdetes_leirasa = hirdetes_leirasa_text!.text!
            ingatlan_ara = ingatlan_ara_text!.text!
            varos = varos_text!.text!
            utca = utca_text!.text!
            hazszam = hazszam_text!.text!
            meret = meret_text!.text!
            
            print ("CÍM")
            print (hirdetes_cime)
            let storyboard = UIStoryboard(name: "AddEstate", bundle: nil)
            let loginView = storyboard.instantiateViewControllerWithIdentifier("AddEstate_2") as! AddEstateViewController
            self.navigationController?.pushViewController(loginView, animated: true)
        } else {
            print ("NOT FILLED")
        }
        
        
        
    }
    //FIRST PAGE END
    
    
    
    @IBOutlet weak var KiemelImage: UIImageView!
    @IBOutlet weak var KiemelLabel: UILabel!
    @IBOutlet weak var KiemelLabelHint: UILabel!
    @IBOutlet weak var AddDescription: UITextField!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        
        
        SpinnerUtil.sharedInstance.get_list_hirdetestipusa{ (json: JSON) in
            self.items.removeAll()
            print ("ASDF")
            print (json)
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
