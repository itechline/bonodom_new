//
//  CalendarItemViewController.swift
//  Bonodom
//
//  Created by Attila Dan on 30/06/16.
//  Copyright © 2016 Itechline. All rights reserved.
//

import UIKit

struct CalendarItemViewDataCell{
    
    init(hours: Int, minutes: Int, foglalt: Bool){
        self.hours = hours
        self.minutes = minutes
        self.foglalt = foglalt
    }
    var hours: Int
    var minutes: Int
    var foglalt: Bool
}
class CalendarItemViewController: BaseMenuItemViewController {
    
    @IBOutlet weak var hour: UILabel!
    @IBOutlet weak var minute: UILabel!
    
    var status = 0
    
    @IBOutlet weak var foglalas: UILabel!
    
    
    override func awakeFromNib() {
        //self.dataText?.font = UIFont.boldSystemFontOfSize(16)
        //self.dataText?.textColor = UIColor(hex: "000000")
    }
    
    override class func height() -> CGFloat {
        return 44
    }
    
    
    override func setData(data: Any?){
        if let data = data as? CalendarItemViewDataCell{
            //var time = data.datum.componentsSeparatedByString(":")
            //let hour_string = time[0].substringFromIndex(time[0].endIndex.advancedBy(-2))
            self.hour.text = String(format: "%02d", data.hours)
            self.minute.text = String(format: "%02d", data.minutes)
            
            if (data.foglalt == false) {
                //self.foglalas_text.setTitleColor(UIColor(hex: "007AFF"), forState: UIControlState.Normal)
                //self.foglalas_text.setTitle("Foglalás", forState: UIControlState.Normal)
                self.foglalas.text = ("Foglalás")
                self.foglalas.textColor = UIColor.blueColor()
            } else {
                //self.foglalas_text.setTitleColor(UIColor(hex: "FF0000"), forState: UIControlState.Normal)
                //self.foglalas_text.setTitle("Foglalt", forState: UIControlState.Normal)
                self.foglalas.text = ("Foglalt")
                self.foglalas.textColor = UIColor.redColor()
            }
            //self.dataImage.image = data.imagePath_menu
            
        }
    }
    
}
