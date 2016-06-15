//
//  RightViewController.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 12/3/14.
//

import UIKit

class RightViewController : UIViewController, PopUpPickerViewDelegate {
    
    var pickerView: PopUpPickerView!
    let array = ["test1", "test2", "test3", "test4", "test5"]
    
    var pickerView2: PopUpPickerView!
    let array2 = ["asd1", "asd2", "asd3", "asd4"]
 
    @IBAction func lift(sender: AnyObject) {
        pickerView = PopUpPickerView()
        pickerView.delegate = self
        if let window = UIApplication.sharedApplication().keyWindow {
            window.addSubview(pickerView)
        } else {
            self.view.addSubview(pickerView)
        }
        pickerView.tag = 1
        pickerView.showPicker()
    }
    
    @IBAction func teszt(sender: AnyObject) {
        pickerView = PopUpPickerView()
        pickerView.delegate = self
        if let window = UIApplication.sharedApplication().keyWindow {
            window.addSubview(pickerView)
        } else {
            self.view.addSubview(pickerView)
        }
        pickerView.tag = 0
        pickerView.showPicker()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // for delegate
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView.tag == 0) {
            return array.count
        } else {
            return array2.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView.tag == 0) {
            return array[row]
        } else {
            return array2[row]
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelect numbers: [Int]) {
        print(numbers)
        //print (String(array[numbers]))
    }
}
