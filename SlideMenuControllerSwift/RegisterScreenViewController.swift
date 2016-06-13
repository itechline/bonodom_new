//
//  RegisterScreenViewController.swift
//  Bonodom
//
//  Created by Attila Dan on 10/06/16.
//  Copyright © 2016 Itechline. All rights reserved.
//

import UIKit
import SwiftyJSON

class RegisterScreenViewController: UIViewController {

    
    @IBOutlet weak var vezeteknev_text: UITextField!
    @IBOutlet weak var keresztnev_text: UITextField!
    @IBOutlet weak var email_text: UITextField!
    @IBOutlet weak var jelszo_text: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
        self.removeNavigationBarItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func register_button(sender: AnyObject) {
        var isFilled = true
        
        if (email_text.text == "") {
            isFilled = false
        }
        
        if (jelszo_text.text == "") {
            isFilled = false
        }
        
        if (vezeteknev_text.text == "") {
            isFilled = false
        }
        
        if (keresztnev_text.text == "") {
            isFilled = false
        }
        
        if (isFilled) {
            let mailString : String = email_text!.text!
            let passString : String = jelszo_text!.text!
            let vezeteknevString : String = vezeteknev_text!.text!
            let keresztnevString : String = keresztnev_text!.text!
            LoginUtil.sharedInstance.doRegistration(mailString, password: passString, vezeteknev: vezeteknevString, keresztnev: keresztnevString, tipus: "maganyszemely",
                                                    onCompletion: { (json: JSON) in
                print (json)
                /*if (json["logged_in"].boolValue) {
                    print ("LOGGED IN")
                    SettingUtil.sharedInstance.setToken(json["token"].stringValue)
                    print ("TOKEN SAVED")
                    dispatch_async(dispatch_get_main_queue(),{
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let subContentsVC = storyboard.instantiateViewControllerWithIdentifier("MainViewController") as! MainViewController
                        self.navigationController?.pushViewController(subContentsVC, animated: true)
                    })
                    
                } else {
                    dispatch_async(dispatch_get_main_queue(),{
                        print ("COULD NOT LOGGED IN")
                        let alert = UIAlertController(title: "HIBA", message: "Hibás felhasználónév vagy jelszó", preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                        self.presentViewController(alert, animated: true, completion: nil)
                    })
                }*/
                
            })
        } else {
            let alert = UIAlertController(title: "HIBA", message: "Töltösön ki minden mezőt!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
