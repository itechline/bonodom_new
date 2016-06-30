//
//  MessageThreadItemView.swift
//  Bonodom
//
//  Created by Attila Dan on 16/06/16.
//  Copyright © 2016 Itechline. All rights reserved.
//

import UIKit
import QuartzCore
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
    
    func heightForView(text:String, label: UILabel) -> CGFloat{
        //let label:UILabel = UILabel(frame: CGRectMake(0, 0, width, CGFloat.max))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.text = text
        
        label.sizeToFit()
        return label.frame.height
    }

    
    
    override func awakeFromNib() {
        self.msg_1.layer.masksToBounds = true
        self.msg_2.layer.masksToBounds = true
        self.msg_1.layer.cornerRadius = 6
        self.msg_1.layer.backgroundColor = UIColor.init(hex: "0066cc").CGColor
        self.msg_2.layer.cornerRadius = 6
        self.msg_2.layer.backgroundColor = UIColor.init(hex: "ffffff").CGColor

        //self.dataText?.font = UIFont.boldSystemFontOfSize(16)
        //self.dataText?.textColor = UIColor(hex: "000000")
    }
    
    override class func height() -> CGFloat {
        return 55
    }
    
    
    override func setData(data: Any?) {
        if let data = data as? MessageThreadItemData {
            if (data.fromme == 0) {
                heightForView(data.conv_msg, label: self.msg_1)
                //self.msg_1.text = data.conv_msg
                self.msg_2.hidden = true
                self.profilepic_2.hidden = true
            } else {
                heightForView(data.conv_msg, label: self.msg_2)
                //self.msg_2.text = data.conv_msg
                self.msg_1.hidden = true
                self.profilepic_1.hidden = true
            }
        }
    }
    
}