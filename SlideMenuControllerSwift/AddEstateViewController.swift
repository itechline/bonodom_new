//
//  AddEstateViewController.swift
//  Bonodom
//
//  Created by Attila Dan on 13/06/16.
//  Copyright © 2016 Itechline. All rights reserved.
//

import UIKit
import SwiftyJSON
import CoreLocation

class AddEstateViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate {

    
    var imagePicker = UIImagePickerController()
    
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
    
    func setButtonBack(button: UIButton) {
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.darkGrayColor().CGColor
    }
    
    @IBOutlet weak var hirdetes_tipusa_text: UIButton!
    @IBAction func hirdetes_tipusa_button(sender: AnyObject) {
        self.dismissKeyboard()
        PickerDialog().show("Hirdetés típusa", options: pickerData_hirdetes_tipus, selected: "0") {
            (value, display) -> Void in
            self.hirdetes_tipusa_text.setTitle(display, forState: UIControlState.Normal)
            self.hirdetes_tipusa = value
            print("Unit selected: \(value)")
        }
    }
    
    @IBOutlet weak var butorozott_text: UIButton!
    @IBAction func butorozott_button(sender: AnyObject) {
        self.dismissKeyboard()
        pickerData_butorozott = [
            ["value": "0", "display": "Nincs megadva"],
            ["value": "1", "display": "Nem"],
            ["value": "2", "display": "Igen"],
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
            forwardGeocoding(varos + " " + utca + " " + hazszam)
            
            
            //self.performSegueWithIdentifier("AddEstate_2", sender: nil)
        } else {
            alertDialog()
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
        pickerData_erkely = [
            ["value": "0", "display": "Nincs megadva"],
            ["value": "1", "display": "Van"],
            ["value": "2", "display": "Nincs"]
        ]
        
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
        pickerData_lift = [
            ["value": "0", "display": "Nincs megadva"],
            ["value": "1", "display": "Van"],
            ["value": "2", "display": "Nincs"]
        ]
        
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
        
        
        
        if (etan == "0" || kilatas == "0" || lift == "0" || futes == "0" ||
            parkolas == "0" || erkely == "0" || ing_tipus == "0" || emelet == "0" || allapot == "0" ||
            szobaszam == "0") {
            alertDialog()
        } else {
            GetAddEstate.estate.insert(AddEstateModel(cim: GetAddEstate.estate[0].cim, varos: GetAddEstate.estate[0].varos, utca: GetAddEstate.estate[0].utca, leiras: GetAddEstate.estate[0].leiras, ar: GetAddEstate.estate[0].ar, meret: GetAddEstate.estate[0].meret, etan: etan, butor: GetAddEstate.estate[0].butor, kilatas: kilatas, lift: lift, futes: futes, parkolas: parkolas, erkely: erkely, tipus: ing_tipus, emelet: emelet, allapot: allapot, szsz: szobaszam, lat: GetAddEstate.estate[0].lat, lng: GetAddEstate.estate[0].lng, e_type: GetAddEstate.estate[0].e_type, zipcode: "", hsz: GetAddEstate.estate[0].hsz, hetfo: "", kedd: "", szerda: "", csut: "", pentek: "", szombat: "", vasarnap: "", kezdes: "", vege: "" ,pictures: nil), atIndex: 0)
            
            let storyboard = UIStoryboard(name: "AddEstate", bundle: nil)
            let loginView = storyboard.instantiateViewControllerWithIdentifier("AddEstate_3")
            self.navigationController?.pushViewController(loginView, animated: true)
        }
    }
    
    
    //SECOND PAGE END
    
    
    
    
    
    //THIRD PAGE
    @IBOutlet weak var image_picker_picture: UIButton!
    @IBAction func image_picker_button(sender: AnyObject) {
        pickImage()
    }
    
    @IBOutlet weak var photo_taker_picture: UIButton!
    @IBAction func photo_taker_button(sender: AnyObject) {
        takePhoto()
    }
    
    var imagesToUpload: [UIImage] = []
    
    @IBAction func kovetkezo_3_button(sender: AnyObject) {
         GetAddEstate.estate.insert(AddEstateModel(cim: GetAddEstate.estate[0].cim,
            varos: GetAddEstate.estate[0].varos,
            utca: GetAddEstate.estate[0].utca,
            leiras: GetAddEstate.estate[0].leiras,
            ar: GetAddEstate.estate[0].ar,
            meret: GetAddEstate.estate[0].meret,
            etan: GetAddEstate.estate[0].etan,
            butor: GetAddEstate.estate[0].butor,
            kilatas: GetAddEstate.estate[0].kilatas,
            lift: GetAddEstate.estate[0].lift,
            futes: GetAddEstate.estate[0].futes,
            parkolas: GetAddEstate.estate[0].parkolas,
            erkely: GetAddEstate.estate[0].erkely,
            tipus: GetAddEstate.estate[0].tipus,
            emelet: GetAddEstate.estate[0].emelet,
            allapot: GetAddEstate.estate[0].allapot,
            szsz: GetAddEstate.estate[0].szsz,
            lat: GetAddEstate.estate[0].lat,
            lng: GetAddEstate.estate[0].lng,
            e_type: GetAddEstate.estate[0].e_type, zipcode: "",
            hsz: GetAddEstate.estate[0].hsz,
            hetfo: "", kedd: "", szerda: "", csut: "", pentek: "", szombat: "", vasarnap: "", kezdes: "", vege: "" ,
            pictures: imagesToUpload), atIndex: 0)
        
        
        let storyboard = UIStoryboard(name: "AddEstate", bundle: nil)
        let loginView = storyboard.instantiateViewControllerWithIdentifier("AddEstate_4")
        self.navigationController?.pushViewController(loginView, animated: true)
    }
    
    
    func pickImage () {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum){
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum;
            imagePicker.allowsEditing = false
            
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    func takePhoto () {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera;
            imagePicker.allowsEditing = false
            
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
        imagesToUpload.append(image)
        
        image_picker_picture.setImage(image, forState: UIControlState.Normal)
        //imageView.image = image
        print ("IMAGE PICKED")
        
    }
    
    //THIRD PAGE END
    
    //FIFTH PAGE
    var alertController = UIAlertController()
    @IBAction func upload_estate(sender: AnyObject) {
    
        
        EstateUtil.sharedInstance.addEstate(GetAddEstate.estate[0].cim, varos: GetAddEstate.estate[0].varos, utca: GetAddEstate.estate[0].utca, leiras: GetAddEstate.estate[0].leiras, ar: GetAddEstate.estate[0].ar, meret: GetAddEstate.estate[0].meret, energiatan_id: GetAddEstate.estate[0].etan, butorozott: GetAddEstate.estate[0].butor, kilatas_id: GetAddEstate.estate[0].kilatas, lift: GetAddEstate.estate[0].lift, futestipus_id: GetAddEstate.estate[0].futes, parkolas_id: GetAddEstate.estate[0].parkolas, erkely: GetAddEstate.estate[0].erkely, tipus_id: GetAddEstate.estate[0].tipus, emelet_id: GetAddEstate.estate[0].emelet, allapot_id: GetAddEstate.estate[0].allapot, szsz_id: GetAddEstate.estate[0].szsz, lat: GetAddEstate.estate[0].lat, lng: GetAddEstate.estate[0].lng, e_type_id: GetAddEstate.estate[0].e_type, zipcode: "4300", hsz: GetAddEstate.estate[0].hsz,
            mon: "0", tue: "0", wed: "0", thu: "0", fri: "0", sat: "0", sun: "0", start: "0", finish: "0" ,onCompletion: { (json: JSON) in
            print (json)
            var err: Bool!
            err = json["error"].boolValue
            if (!err) {
                dispatch_async(dispatch_get_main_queue(),{
                //self.progressBarDisplayer("Képek feltöltése", true)
                    self.showLoadingDialog()
                for i in 0...GetAddEstate.estate[0].pictures!.count-1 {
                    //self.strLabel.text = String(i)
                    self.UploadRequest(GetAddEstate.estate[0].pictures![i], ing_hash: json["hash"].stringValue, i: i, id: json["id"].intValue)
                }
                })
            }
                
                    
                
        })
    }
    
    
    
    //FIFTH PAGE END
    
    func showLoadingDialog() {
        alertController = UIAlertController(title: nil, message: "Please wait\n\n", preferredStyle: UIAlertControllerStyle.Alert)
        let spinnerIndicator: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        spinnerIndicator.center = CGPointMake(135.0, 65.5)
        spinnerIndicator.color = UIColor.blackColor()
        spinnerIndicator.startAnimating()
        alertController.view.addSubview(spinnerIndicator)
        self.presentViewController(alertController, animated: false, completion: nil)
    }
    
    var messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    
    func progressBarDisplayer(msg:String, _ indicator:Bool ) {
        strLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 200, height: 50))
        strLabel.text = msg
        strLabel.textColor = UIColor.whiteColor()
        messageFrame = UIView(frame: CGRect(x: view.frame.midX - 90, y: view.frame.midY - 25 , width: 180, height: 50))
        messageFrame.layer.cornerRadius = 15
        messageFrame.backgroundColor = UIColor(white: 0, alpha: 0.7)
        if indicator {
            activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.White)
            activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
            activityIndicator.startAnimating()
            messageFrame.addSubview(activityIndicator)
        }
        messageFrame.addSubview(strLabel)
        view.addSubview(messageFrame)
    }
    
    func alertDialog() {
        let alert = UIAlertController(title: "HIBA", message: "Töltösön ki minden mezőt helyesen!", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBOutlet weak var KiemelImage: UIImageView!
    @IBOutlet weak var KiemelLabel: UILabel!
    @IBOutlet weak var KiemelLabelHint: UILabel!
    @IBOutlet weak var AddDescription: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*setButtonBack(hirdetes_tipusa_text)
        setButtonBack(butorozott_text)
        setButtonBack(szobaszam_text)
        setButtonBack(allapot_text)
        setButtonBack(emelet_text)
        setButtonBack(ingatlan_tipus_text)
        setButtonBack(erkely_text)
        setButtonBack(parkolas_text)
        setButtonBack(futes_text)
        setButtonBack(lift_text)
        setButtonBack(etan_text)
        setButtonBack(kilatas_text)*/
        
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
    
    var lat = 0.0
    var lng = 0.0
    func forwardGeocoding(address: String) {
        CLGeocoder().geocodeAddressString(address, completionHandler: { (placemarks, error) in
            if error != nil {
                print(error)
                GetAddEstate.estate.append(AddEstateModel(cim: self.hirdetes_cime, varos: self.varos, utca: self.utca, leiras: self.hirdetes_leirasa, ar: self.ingatlan_ara, meret: self.meret, etan: "", butor: self.butorozott, kilatas: "", lift: "", futes: "", parkolas: "", erkely: "", tipus: "", emelet: "", allapot: "", szsz: "", lat: "0", lng: "0", e_type: self.hirdetes_tipusa, zipcode: "", hsz: self.hazszam, hetfo: "", kedd: "", szerda: "", csut: "",
                    pentek: "", szombat: "", vasarnap: "", kezdes: "", vege: "" ,pictures: nil))
                
                let storyboard = UIStoryboard(name: "AddEstate", bundle: nil)
                let loginView = storyboard.instantiateViewControllerWithIdentifier("AddEstate_2")
                self.navigationController?.pushViewController(loginView, animated: true)
                return
            }
            if placemarks?.count > 0 {
                let placemark = placemarks?[0]
                let location = placemark?.location
                let coordinate = location?.coordinate
                print("\nlat: \(coordinate!.latitude), long: \(coordinate!.longitude)")
                self.lat = coordinate!.latitude
                self.lng = coordinate!.longitude
                
                GetAddEstate.estate.append(AddEstateModel(cim: self.hirdetes_cime, varos: self.varos, utca: self.utca, leiras: self.hirdetes_leirasa, ar: self.ingatlan_ara, meret: self.meret, etan: "", butor: self.butorozott, kilatas: "", lift: "", futes: "", parkolas: "", erkely: "", tipus: "", emelet: "", allapot: "", szsz: "", lat: String(self.lat), lng: String(self.lng), e_type: self.hirdetes_tipusa, zipcode: "", hsz: self.hazszam, hetfo: "", kedd: "", szerda: "", csut: "",
                    pentek: "", szombat: "", vasarnap: "", kezdes: "", vege: "" ,pictures: nil))
                
                let storyboard = UIStoryboard(name: "AddEstate", bundle: nil)
                let loginView = storyboard.instantiateViewControllerWithIdentifier("AddEstate_2")
                self.navigationController?.pushViewController(loginView, animated: true)
            }
        })
    }
    
    func loadSpinners() {
        SpinnerUtil.sharedInstance.get_list_ingatlanszoba{ (json: JSON) in
            self.items.removeAll()
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
    
    
    func UploadRequest(image: UIImage, ing_hash: String, i: Int, id: Int)
    {
        let url = NSURL(string: "https://bonodom.com/upload/uploadtoserver?ing_hash=" + ing_hash)
        
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
            if (i == GetAddEstate.estate[0].pictures!.count-1) {
                print ("FINISHED UPLOADING")
                //GetAddEstate.estate.removeAll()
                self.alertController.dismissViewControllerAnimated(true, completion: nil)
                let storyboard = UIStoryboard(name: "SubContentsViewController", bundle: nil)
                let subContentsVC = storyboard.instantiateViewControllerWithIdentifier("SubContentsViewController") as! SubContentsViewController
                subContentsVC.id = id
                self.navigationController?.pushViewController(subContentsVC, animated: true)
            }
        }
        task.resume()
    }
    
    
    func generateBoundaryString() -> String
    {
        return "Boundary-\(NSUUID().UUIDString)"
    }

}
