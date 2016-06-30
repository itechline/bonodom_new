//
//  MessageModel.swift
//  Bonodom
//
//  Created by Attila Dán on 2016. 06. 30..
//  Copyright © 2016. Itechline. All rights reserved.
//

import SwiftyJSON

class MessageModel {
    var conv_msg: String!
    var fromme: Int!
    
    required init(json: JSON) {
        conv_msg = json["conv_msg"].stringValue
        fromme = json["fromme"].intValue
    }
}
