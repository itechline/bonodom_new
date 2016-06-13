//
//  LoginScreenViewController.swift
//  Bonodom
//
//  Created by Attila Dan on 10/06/16.
//  Copyright © 2016 Itechline. All rights reserved.
//

import UIKit
import SwiftyJSON

class LoginScreenViewController: UIViewController {
    

    @IBOutlet weak var pass: UITextField!
    @IBOutlet weak var email: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
    }
    
    @IBAction func loginButton(sender: AnyObject) {
        var isFilled = true
        if (email.text == "") {
            isFilled = false
        }
        
        if (pass.text == "") {
            isFilled = false
        }
        
        if (isFilled) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let subContentsVC = storyboard.instantiateViewControllerWithIdentifier("MainViewController") as! MainViewController
            let mailString : String = email!.text!
            let passString : String = pass!.text!
            LoginUtil.sharedInstance.doLogin(mailString, password: passString, onCompletion: { (json: JSON) in
                print (json)
                if (json["logged_in"].boolValue) {
                    print ("LOGGED IN")
                    SettingUtil.sharedInstance.setToken(json["token"].stringValue)
                    print ("TOKEN SAVED")
                    dispatch_async(dispatch_get_main_queue(),{
                        self.navigationController?.pushViewController(subContentsVC, animated: true)
                    })
                    
                } else {
                    dispatch_async(dispatch_get_main_queue(),{
                        print ("COULD NOT LOGGED IN")
                        let alert = UIAlertController(title: "HIBA", message: "Hibás felhasználónév vagy jelszó", preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                        self.presentViewController(alert, animated: true, completion: nil)
                    })
                }
                
                })
        } else {
            let alert = UIAlertController(title: "HIBA", message: "Töltösön ki minden mezőt!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
