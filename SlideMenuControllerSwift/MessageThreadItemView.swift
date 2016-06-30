//
//  MessageThreadItemView.swift
//  Bonodom
//
//  Created by Attila Dan on 16/06/16.
//  Copyright © 2016 Itechline. All rights reserved.
//

import UIKit
import SwiftyJSON

struct MessageThreadItemData {
    
    init(conv_msg: String, fromme: Int) {
        self.conv_msg = conv_msg
        self.fromme = fromme
    }
    var conv_msg: String
    var fromme: Int
}

class MessageThreadItemView: BaseTableViewCell {
    @IBOutlet weak var profilepic_1: UIImageView!

    @IBOutlet weak var msg_1: UILabel!
    
    @IBOutlet weak var profilepic_2: UIImageView!
    
    @IBOutlet weak var msg_2: UILabel!
    
    
    override func awakeFromNib() {
        //self.dataText?.font = UIFont.boldSystemFontOfSize(16)
        //self.dataText?.textColor = UIColor(hex: "000000")
    }
    
    override class func height() -> CGFloat {
        return 55
    }
    
    
    override func setData(data: Any?) {
        if let data = data as? MessageThreadItemData {
            if (data.fromme == 0) {
                self.msg_1.text = data.conv_msg
                //self.msg_2.enabled = false
            } else {
                self.msg_2.text = data.conv_msg
                //self.msg_1.enabled = false
            }
        }
    }
    
}