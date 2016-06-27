//
//  SwiftViewController.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 1/19/15.
//  Copyright (c) 2015 Yuji Hato. All rights reserved.
//



import UIKit
import SwiftyJSON

class SwiftViewController: UIViewController {
    @IBOutlet weak var vezetek_nev_text: UITextField!
    @IBOutlet weak var kereszt_nev_text: UITextField!
    @IBOutlet weak var telefonszam_text: UITextField!
    @IBOutlet weak var email_text: UITextField!
    @IBOutlet weak var jelszo_1: UITextField!
    @IBOutlet weak var jelszo_2: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        LoginUtil.sharedInstance.getProfile({ (json: JSON) in
            print (json)
            
            dispatch_async(dispatch_get_main_queue(),{
                self.vezetek_nev_text.text = json["veznev"].stringValue
                self.kereszt_nev_text.text = json["kernev"].stringValue
                self.telefonszam_text.text = json["mobil"].stringValue
                self.email_text.text = json["email"].stringValue
            })
        })
    }
    
    @IBAction func save_button(sender: AnyObject) {
        let veznev : String = vezetek_nev_text!.text!
        let kernev : String = kereszt_nev_text!.text!
        let telo : String = telefonszam_text!.text!
        let mail : String = email_text!.text!
        let jelszo1 : String = jelszo_1!.text!
        let jelszo2 : String = jelszo_2!.text!
        
        if (jelszo1 != jelszo2) {
            let alert = UIAlertController(title: "HIBA", message: "A két jelszó nem egyezik meg!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        } else if (jelszo1.length < 6 || jelszo2.length < 6) {
            let alert = UIAlertController(title: "HIBA", message: "Jelszónak legalább 6 karakter hosszúnak kell lennie!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            LoginUtil.sharedInstance.doUpdateProfile(veznev, keresztnev: kernev, mobile: telo, jelsz: jelszo1, onCompletion: { (json: JSON) in
                print ("UPDATE PROFILE")
                print (json)
                    dispatch_async(dispatch_get_main_queue(),{
                    
                    })
            })
        }
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
    }
    
}