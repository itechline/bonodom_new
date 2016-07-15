//
//  CalendarItemViewController.swift
//  Bonodom
//
//  Created by Attila Dan on 30/06/16.
//  Copyright © 2016 Itechline. All rights reserved.
//

import UIKit

struct CalendarItemViewDataCell{
    
    init(id: Int, ingatlan_id: Int, datum: String, status: Int, fel_id: Int){
        self.id = id
        self.ingatlan_id = ingatlan_id
        self.datum = datum
        self.status = status
        self.fel_id = fel_id
    }
    var id: Int
    var ingatlan_id: Int
    var datum: String
    var status: Int
    var fel_id: Int
}
class CalendarItemViewController: BaseMenuItemViewController {
    
    @IBOutlet weak var hour: UILabel!
    @IBOutlet weak var minute: UILabel!
    
    var status = 0
    @IBOutlet weak var foglalas_text: UIButton!
    @IBAction func foglalas_button(sender: AnyObject) {
        if (status == 1) {
            
        } else {
            NSNotificationCenter.defaultCenter().postNotificationName("snackbar_reserved", object: nil)
        }
    }
    
    override func awakeFromNib() {
        //self.dataText?.font = UIFont.boldSystemFontOfSize(16)
        //self.dataText?.textColor = UIColor(hex: "000000")
    }
    
    override class func height() -> CGFloat {
        return 44
    }
    
    
    override func setData(data: Any?){
        if let data = data as? CalendarItemViewDataCell{
            var time = data.datum.componentsSeparatedByString(":")
            let hour_string = time[0].substringFromIndex(time[0].endIndex.advancedBy(-2))
            self.hour.text = hour_string
            self.minute.text = time[1]
            
            if (data.status != 1) {
                self.foglalas_text.setTitleColor(UIColor(hex: "007AFF"), forState: UIControlState.Normal)
                self.foglalas_text.setTitle("Foglalás", forState: UIControlState.Normal)
            } else {
                self.foglalas_text.setTitleColor(UIColor(hex: "FF0000"), forState: UIControlState.Normal)
                self.foglalas_text.setTitle("Foglalt", forState: UIControlState.Normal)
            }
            //self.dataImage.image = data.imagePath_menu
            
        }
    }
    
}
