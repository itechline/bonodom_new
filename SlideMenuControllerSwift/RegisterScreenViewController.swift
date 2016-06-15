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
    
    @IBOutlet weak var city_text: UITextField!
    @IBOutlet weak var mobile_text: UITextField!
    
    var lat = 0.0
    var lng = 0.0
    var mobileString = ""
    
    var tipus = "maganyszemely"
    
    
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
    
    @IBAction func register_button(sender: AnyObject) {
        var isFilled = true
        
        if (email_text.text != "") {
            let mailString_test : String = email_text!.text!
            if (!isValidEmail(mailString_test)) {
                isFilled = false
            }
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
            LoginUtil.sharedInstance.doRegistration(mailString, password: passString, vezeteknev: vezeteknevString, keresztnev: keresztnevString, tipus: tipus,
                                                    onCompletion: { (json: JSON) in
                print (json)
                if (json["status"].boolValue) {
                    SettingUtil.sharedInstance.setToken(json["token"].stringValue)
                    print ("TOKEN SAVED")
                    dispatch_async(dispatch_get_main_queue(),{
                        let storyboard = UIStoryboard(name: "LoginView", bundle: nil)
                        let subContentsVC = storyboard.instantiateViewControllerWithIdentifier("FirstSetting") as! RegisterScreenViewController
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
            /*let storyboard = UIStoryboard(name: "LoginView", bundle: nil)
            let subContentsVC = storyboard.instantiateViewControllerWithIdentifier("FirstSetting") as! RegisterScreenViewController
            self.navigationController?.pushViewController(subContentsVC, animated: true)*/
            
            missingFieldsUIAlert()
        }
    }
    
    func missingFieldsUIAlert() {
        let alert = UIAlertController(title: "HIBA", message: "Töltösön ki minden mezőt!", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(testStr)
    }
    
    
    
    
    @IBAction func updatereg_finish(sender: AnyObject) {
        LoginUtil.sharedInstance.doUpdateReg(String(lat), lng: String(lng), mobile: mobileString, onCompletion: { (json: JSON) in
            print (json)
            if (!json["error"].boolValue) {
                dispatch_async(dispatch_get_main_queue(),{
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let mvc = storyboard.instantiateViewControllerWithIdentifier("MainViewController") as! MainViewController
                    self.navigationController?.pushViewController(mvc, animated: true)
                })
                
            } else {
                dispatch_async(dispatch_get_main_queue(),{
                    let alert = UIAlertController(title: "HIBA", message: "Adatok hozzáadása sikertelen", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                })
            }
        })
    }
    @IBAction func take_photo(sender: AnyObject) {
        let alert = UIAlertController(title: "Türelem", message: "A funkció a következő frissítéssel válik elérhetővé!", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func updatereg_next_to_photo(sender: AnyObject) {
        if (mobile_text.text != "") {
            mobileString = mobile_text!.text!
            let storyboard = UIStoryboard(name: "LoginView", bundle: nil)
            let subContentsVC = storyboard.instantiateViewControllerWithIdentifier("ThirdSetting") as! RegisterScreenViewController
            self.navigationController?.pushViewController(subContentsVC, animated: true)
        } else {
            missingFieldsUIAlert()
        }
    }

    @IBAction func updatereg_next_to_phone(sender: AnyObject) {
        if (city_text.text != "") {
            let city : String = city_text!.text!
            forwardGeocoding(city)
            let storyboard = UIStoryboard(name: "LoginView", bundle: nil)
            let subContentsVC = storyboard.instantiateViewControllerWithIdentifier("SecondSetting") as! RegisterScreenViewController
            self.navigationController?.pushViewController(subContentsVC, animated: true)
        } else {
            missingFieldsUIAlert()
        }
    }
    
    @IBAction func ProfileTypeSelector(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            vezeteknev_text.placeholder = "Vezetéknév:"
            keresztnev_text.placeholder = "Keresztnév:"
            vezeteknev_text.hidden = false
            tipus = "maganyszemely"
        } else {
            vezeteknev_text.hidden = true
            keresztnev_text.placeholder = "Cégnév:"
            tipus = "ingatlanos"
        }
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
                self.lat = coordinate!.latitude
                self.lng = coordinate!.longitude
                print (self.lat)
                print (self.lng)
                /*if placemark?.areasOfInterest?.count > 0 {
                 let areaOfInterest = placemark!.areasOfInterest![0]
                 print(areaOfInterest)
                 } else {
                 print("No area of interest found.")
                 }*/
            }
        })
    }
    

}
