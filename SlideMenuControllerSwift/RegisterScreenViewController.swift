//
//  RegisterScreenViewController.swift
//  Bonodom
//
//  Created by Attila Dan on 10/06/16.
//  Copyright © 2016 Itechline. All rights reserved.
//

import UIKit
import SwiftyJSON
import CoreLocation

class RegisterScreenViewController: UIViewController, CLLocationManagerDelegate {

    
    @IBOutlet weak var vezeteknev_text: UITextField!
    @IBOutlet weak var keresztnev_text: UITextField!
    @IBOutlet weak var email_text: UITextField!
    @IBOutlet weak var jelszo_text: UITextField!
    
    var locManager = CLLocationManager()
    var city: CLLocation!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
        self.removeNavigationBarItem()
        
        //forwardGeocoding("Debrecen")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func forwardGeocoding(address: String) {
        CLGeocoder().geocodeAddressString(address, completionHandler: { (placemarks, error) in
            if error != nil {
                print(error)
                return
            }
            if placemarks?.count > 0 {
                let placemark = placemarks?[0]
                let location = placemark?.location
                let coordinate = location?.coordinate
                print("\nlat: \(coordinate!.latitude), long: \(coordinate!.longitude)")
                /*if placemark?.areasOfInterest?.count > 0 {
                    let areaOfInterest = placemark!.areasOfInterest![0]
                    print(areaOfInterest)
                } else {
                    print("No area of interest found.")
                }*/
            }
        })
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
                if (json["status"].boolValue) {
                    SettingUtil.sharedInstance.setToken(json["token"].stringValue)
                    print ("TOKEN SAVED")
                    dispatch_async(dispatch_get_main_queue(),{
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let subContentsVC = storyboard.instantiateViewControllerWithIdentifier("MainViewController") as! MainViewController
                        self.navigationController?.pushViewController(subContentsVC, animated: true)
                    })
                    
                } else {
                    dispatch_async(dispatch_get_main_queue(),{
                        let alert = UIAlertController(title: "HIBA", message: "Regisztráció nem sikerült", preferredStyle: UIAlertControllerStyle.Alert)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
