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
            //self.dataImage.image = data.imagePath_menu
            
        }
    }
    
}
