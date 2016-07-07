//
//  AdmonitorDataCell.swift
//  Bonodom
//
//  Created by Attila Dán on 2016. 07. 07..
//  Copyright © 2016. Itechline. All rights reserved.
//

import UIKit
import SwiftyJSON

struct AdmonitorData {
    
    init(id: Int, fel_id: Int, name: String, ingatlan_butorozott: Int, ingatlan_lift: Int, ingatlan_erkely: Int, ingatlan_meret: Int, ingatlan_szsz_min: Int, ingatlan_szsz_max: Int, ingatlan_emelet_max: Int, ingatlan_emelet_min: Int, ingatlan_allapot_id: Int, ingatlan_tipus_id: Int, ingatlan_energiatan_id: Int, ingatlan_kilatas_id: Int, ingatlan_parkolas_id: Int, ingatlan_ar_max: String, ingatlan_ar_min: String, keyword: String) {
        self.id = id
        self.fel_id = fel_id
        self.name = name
        self.ingatlan_butorozott = ingatlan_butorozott
        self.ingatlan_lift = ingatlan_lift
        self.ingatlan_erkely = ingatlan_erkely
        self.ingatlan_meret = ingatlan_meret
        self.ingatlan_szsz_min = ingatlan_szsz_min
        self.ingatlan_szsz_max = ingatlan_szsz_max
        self.ingatlan_emelet_max = ingatlan_emelet_max
        self.ingatlan_emelet_min = ingatlan_emelet_min
        self.ingatlan_allapot_id = ingatlan_allapot_id
        self.ingatlan_tipus_id = ingatlan_tipus_id
        self.ingatlan_energiatan_id = ingatlan_energiatan_id
        self.ingatlan_kilatas_id = ingatlan_kilatas_id
        self.ingatlan_parkolas_id = ingatlan_parkolas_id
        self.ingatlan_ar_max = ingatlan_ar_max
        self.ingatlan_ar_min = ingatlan_ar_min
        self.keyword = keyword
    }
    var id: Int
    var fel_id: Int
    var name: String
    var ingatlan_butorozott: Int
    var ingatlan_lift: Int
    var ingatlan_erkely: Int
    var ingatlan_meret: Int
    var ingatlan_szsz_min: Int
    var ingatlan_szsz_max: Int
    var ingatlan_emelet_max: Int
    var ingatlan_emelet_min: Int
    var ingatlan_allapot_id: Int
    var ingatlan_tipus_id: Int
    var ingatlan_energiatan_id: Int
    var ingatlan_kilatas_id: Int
    var ingatlan_parkolas_id: Int
    var ingatlan_ar_max: String
    var ingatlan_ar_min: String
    var keyword: String
}

class AdmonitorDataCell: BaseTableViewCell {
    
    @IBOutlet weak var name: UILabel!
    var id = 0
    
    @IBAction func delete_admonitor(sender: AnyObject) {
        let fav: [String:AnyObject] = [ "id": String(id)]
        NSNotificationCenter.defaultCenter().postNotificationName("delete_admonitor", object: fav)
    }
    
    override func awakeFromNib() {
        //self.dataText?.font = UIFont.boldSystemFontOfSize(16)
        //self.dataText?.textColor = UIColor(hex: "000000")
    }
    
    override class func height() -> CGFloat {
        return 60
    }
    
    
    override func setData(data: Any?) {
        if let data = data as? AdmonitorData {
            self.name.text = data.name
            self.id = data.id
        }
    }
    
}
