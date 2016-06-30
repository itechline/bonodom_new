//
//  MessageItemViewController.swift
//  Bonodom
//
//  Created by Attila Dan on 06/06/16.
//  Copyright © 2016 Itechline. All rights reserved.
//

import UIKit
import SwiftyJSON

struct MessageTableCellData {
    
    init(date: String, fel_vezeteknev: String, fel_keresztnev: String, ingatlan_varos: String, ingatlan_utca: String, hash: String, uid: String) {
        self.date = date
        self.fel_keresztnev = fel_keresztnev
        self.fel_vezeteknev = fel_vezeteknev
        self.ingatlan_varos = ingatlan_varos
        self.ingatlan_utca = ingatlan_utca
        self.hash = hash
        self.uid = uid
    }
    var date: String
    var fel_vezeteknev: String
    var fel_keresztnev: String
    var ingatlan_varos: String
    var ingatlan_utca: String
    var hash: String
    var uid: String
}

class MessageTableCell: BaseTableViewCell {
    @IBOutlet weak var name_text: UILabel!
    @IBOutlet weak var date_text: UILabel!
    @IBOutlet weak var adress_text: UILabel!
    @IBOutlet weak var profile_picture: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    override func awakeFromNib() {
        //self.dataText?.font = UIFont.boldSystemFontOfSize(16)
        //self.dataText?.textColor = UIColor(hex: "000000")
    }
    
    override class func height() -> CGFloat {
        return 100
    }
    
    
    override func setData(data: Any?) {
        if let data = data as? MessageTableCellData {
            self.name_text.text = data.fel_vezeteknev + " " + data.fel_keresztnev
            self.date_text.text = data.date
            self.adress_text.text = data.ingatlan_varos + " " + data.ingatlan_utca
            
            
        }
    }

}
