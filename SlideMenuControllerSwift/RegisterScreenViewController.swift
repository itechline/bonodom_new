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

class RegisterScreenViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mainhouseheight: UIImageView!
    @IBOutlet weak var spacebetweenTerms: NSLayoutConstraint!
    @IBOutlet weak var logoheight: NSLayoutConstraint!
    var imagePicker = UIImagePickerController()
    
    @IBOutlet weak var vezeteknev_text: UITextField!
    @IBOutlet weak var keresztnev_text: UITextField!
    @IBOutlet weak var email_text: UITextField!
    @IBOutlet weak var jelszo_text: UITextField!
    
    @IBOutlet weak var city_text: UITextField!
    @IBOutlet weak var mobile_text: UITextField!
    
    var lat = 0.0
    var lng = 0.0
    var mobileString = ""
    let screensize = UIScreen.mainScreen().bounds
    
    var tipus = "maganszemely"
    
    var alertController = UIAlertController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logoheight.constant = screensize.height/6
        spacebetweenTerms.constant = screensize.height/25
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
        } else {
            isFilled = false
            email_text.attributedPlaceholder = NSAttributedString(string:"Email:",
                                                                  attributes:[NSForegroundColorAttributeName: UIColor.redColor()])
        }
        
        if (jelszo_text.text == "") {
            isFilled = false
            jelszo_text.attributedPlaceholder = NSAttributedString(string:"Jelszó:",
                                                                  attributes:[NSForegroundColorAttributeName: UIColor.redColor()])
        }
        
        if (vezeteknev_text.text == "") {
            isFilled = false
            vezeteknev_text.attributedPlaceholder = NSAttributedString(string:"Vezetéknév:",
                                                                  attributes:[NSForegroundColorAttributeName: UIColor.redColor()])
        }
        
        if (keresztnev_text.text == "") {
            isFilled = false
            if (tipus == "maganszemely") {
                keresztnev_text.attributedPlaceholder = NSAttributedString(string:"Keresztnév:",
                                                                           attributes:[NSForegroundColorAttributeName: UIColor.redColor()])
            } else {
                keresztnev_text.attributedPlaceholder = NSAttributedString(string:"Cégnév:",
                                                                           attributes:[NSForegroundColorAttributeName: UIColor.redColor()])
            }
        }
        
        if (isFilled) {
            showLoadingDialog()
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
                        self.alertController.dismissViewControllerAnimated(true, completion: nil)
                        let storyboard = UIStoryboard(name: "LoginView", bundle: nil)
                        let subContentsVC = storyboard.instantiateViewControllerWithIdentifier("FirstSetting") as! RegisterScreenViewController
                        self.navigationController?.pushViewController(subContentsVC, animated: true)
                    })
                    
                } else {
                    dispatch_async(dispatch_get_main_queue(),{
                        self.alertController.dismissViewControllerAnimated(true, completion: nil)
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
    
    func showLoadingDialog() {
        alertController = UIAlertController(title: nil, message: "Please wait\n\n", preferredStyle: UIAlertControllerStyle.Alert)
        let spinnerIndicator: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        spinnerIndicator.center = CGPointMake(135.0, 65.5)
        spinnerIndicator.color = UIColor.blackColor()
        spinnerIndicator.startAnimating()
        alertController.view.addSubview(spinnerIndicator)
        self.presentViewController(alertController, animated: false, completion: nil)
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
        showLoadingDialog()
        LoginUtil.sharedInstance.doUpdateReg(String(lat), lng: String(lng), mobile: mobileString, onCompletion: { (json: JSON) in
            print (json)
            if (!json["error"].boolValue) {
                
                dispatch_async(dispatch_get_main_queue(),{
                    if (self.imageToUpload != nil) {
                        self.UploadRequest(self.imageToUpload!, token: SettingUtil.sharedInstance.getToken())
                    } else {
                        self.alertController.dismissViewControllerAnimated(true, completion: nil)
                        /*let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let mvc = storyboard.instantiateViewControllerWithIdentifier("MainViewController") as! MainViewController
                        self.navigationController?.pushViewController(mvc, animated: true)*/
                        self.navigationController?.popViewControllerAnimated(true);
                    }
                })
                
            } else {
                dispatch_async(dispatch_get_main_queue(),{
                    self.alertController.dismissViewControllerAnimated(true, completion: nil)
                    let alert = UIAlertController(title: "HIBA", message: "Adatok hozzáadása sikertelen", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                })
            }
        })
    }
    
    var imageToUpload: UIImage? = nil
    func pickImage() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera;
            imagePicker.allowsEditing = false
            
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    func takePhoto() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum){
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum;
            imagePicker.allowsEditing = false
            
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    
    @IBOutlet weak var take_photo_image: UIButton!
    @IBAction func take_photo(sender: AnyObject) {
        takePhoto()
    }
    
    @IBOutlet weak var pick_image_image: UIButton!
    @IBAction func pick_image(sender: AnyObject) {
        pickImage()
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
        imageToUpload = image
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
            tipus = "maganszemely"
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
    
    
    
    func UploadRequest(image: UIImage, token: String)
    {
        let url = NSURL(string: "https://bonodom.com/upload/uplodeprofilepicture?token=" + token)
        
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        
        let boundary = generateBoundaryString()
        
        //define the multipart request type
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        /*if (image == nil)
         {
         return
         }*/
        
        let image_data = UIImagePNGRepresentation(image)
        
        if(image_data == nil)
        {
            return
        }
        
        
        let body = NSMutableData()
        
        let fname = "test.png"
        let mimetype = "image/png"
        
        //define the data post parameter
        
        body.appendData("--\(boundary)\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData("Content-Disposition:form-data; name=\"test\"\r\n\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData("hi\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        
        
        
        body.appendData("--\(boundary)\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData("Content-Disposition:form-data; name=\"file\"; filename=\"\(fname)\"\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData("Content-Type: \(mimetype)\r\n\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData(image_data!)
        body.appendData("\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        
        
        body.appendData("--\(boundary)--\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        
        
        
        request.HTTPBody = body
        
        
        
        let session = NSURLSession.sharedSession()
        
        
        let task = session.dataTaskWithRequest(request) {
            (
            let data, let response, let error) in
            
            guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
                print("error")
                return
            }
            
            let dataString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print(dataString)
            
            
            print ("FINISHED UPLOADING")
            self.alertController.dismissViewControllerAnimated(true, completion: nil)
            /*let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mvc = storyboard.instantiateViewControllerWithIdentifier("MainViewController") as! MainViewController
            self.navigationController?.pushViewController(mvc, animated: true)*/
            self.navigationController?.popViewControllerAnimated(true);
        }
        task.resume()
    }
    
    
    func generateBoundaryString() -> String
    {
        return "Boundary-\(NSUUID().UUIDString)"
    }
    

}
