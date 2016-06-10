//
//  RightViewController.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 12/3/14.
//

import UIKit

class RightViewController : UIViewController/*, UIPickerViewDelegate, UIPickerViewDataSource*/ {
    
    /*@IBOutlet weak var estateTypePicker: UIPickerView!
    
    var estatetypes = ["Nincs Megadva", "Mindegy", "Tégla", "Panel", "Egyéb"]
    */
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // self.estateTypePicker.delegate = self
       // self.estateTypePicker.dataSource = self
    }
    
    /*func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return estatetypes.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return estatetypes[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print (estatetypes[row])
    }*/
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
