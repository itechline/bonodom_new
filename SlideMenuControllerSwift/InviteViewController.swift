//
//  InviteViewController.swift
//  Bonodom
//
//  Created by Attila Dan on 03/06/16.
//  Copyright © 2016 Itechline. All rights reserved.
//

import UIKit
import SwiftyJSON

class InviteViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBarItem()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var mail1: UITextField!
    @IBOutlet weak var mail2: UITextField!
    @IBOutlet weak var mail3: UITextField!
    @IBOutlet weak var mail4: UITextField!

    @IBAction func send_button(sender: AnyObject) {
        let email1 : String = mail1!.text!
        let email2 : String = mail2!.text!
        let email3 : String = mail3!.text!
        let email4 : String = mail4!.text!
        if !(email1.isEmpty && email2.isEmpty && email3.isEmpty && email4.isEmpty) {
            EstateUtil.sharedInstance.send_invites(email1, email2: email2, email3: email3, email4: email4, email5: "", onCompletion: { (json: JSON) in
                print ("SEND INVITES")
                print (json)
                if (!json["error"].boolValue) {
                    dispatch_async(dispatch_get_main_queue(),{
                        let alert = UIAlertController(title: "Köszönjük!", message: "Meghívásait elküldtük!", preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                        self.presentViewController(alert, animated: true, completion: nil)
                    })
                }
            })
        } else {
            let alert = UIAlertController(title: "HIBA!", message: "Töltsön ki legalább egy mezőt!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
    }
}
