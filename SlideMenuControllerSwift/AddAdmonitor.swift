//
//  AddAdmonitor.swift
//  Bonodom
//
//  Created by Attila Dán on 2016. 07. 07..
//  Copyright © 2016. Itechline. All rights reserved.
//

import UIKit

class AddAdmonitor: UIViewController {
    var figyelo = ""
    var search = ""
    var ar_min = ""
    var ar_max = ""
    var kivitel_id = 0
    var szintek_min_id = 0
    var szintek_max_id = 0
    var szobaszam_min_id = 0
    var szobaszam_max_id = 0
    var lif_id = 0
    var erkely_id = 0
    var meret_id = 0
    var kilatas_id = 0
    var butorozott_id = 0
    var parkolas_id = 0
    var allapot_id = 0
    var etan_id = 0
    
    @IBOutlet weak var figyelo_neve: UITextField!
    @IBOutlet weak var kereses: UITextField!
    @IBOutlet weak var ar_min_text: UITextField!
    @IBOutlet weak var ar_max_text: UITextField!
    
    @IBOutlet weak var kivitel_text: UIButton!
    @IBAction func kivitel_button(sender: AnyObject) {
    }
    
    @IBOutlet weak var szintek_text: UIButton!
    @IBAction func szintek_button(sender: AnyObject) {
    }
    
    @IBOutlet weak var szintek_max_text: UIButton!
    @IBAction func szintek_max_button(sender: AnyObject) {
    }
    
    @IBOutlet weak var szobaszam_min_text: UIButton!
    @IBAction func szobaszam_min_button(sender: AnyObject) {
    }
    
    @IBOutlet weak var szobaszam_max_text: UIButton!
    @IBAction func szobaszam_max_button(sender: AnyObject) {
    }
    
    @IBOutlet weak var lift_text: UIButton!
    @IBAction func lift_button(sender: AnyObject) {
    }
    
    @IBOutlet weak var erkely_text: UIButton!
    @IBAction func erkely_button(sender: AnyObject) {
    }
    
    @IBOutlet weak var meret_text: UIButton!
    @IBAction func meret_button(sender: AnyObject) {
    }
    
    @IBOutlet weak var kilatas_text: UIButton!
    @IBAction func kilatas_button(sender: AnyObject) {
    }
    
    @IBOutlet weak var butorozott_text: UIButton!
    @IBAction func butorozott_button(sender: AnyObject) {
    }
    
    @IBOutlet weak var parkolas_text: UIButton!
    @IBAction func parkolas_button(sender: AnyObject) {
    }
    
    @IBOutlet weak var allapot_text: UIButton!
    @IBAction func allapot_button(sender: AnyObject) {
    }
    
    @IBOutlet weak var etan_text: UIButton!
    @IBAction func etan_button(sender: AnyObject) {
    }
    
    @IBAction func save_admonitor_button(sender: AnyObject) {
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}
