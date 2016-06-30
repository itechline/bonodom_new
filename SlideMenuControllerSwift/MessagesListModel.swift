//
//  MessagesListModel.swift
//  Bonodom
//
//  Created by Attila Dán on 2016. 06. 30..
//  Copyright © 2016. Itechline. All rights reserved.
//

import SwiftyJSON

class MessagesListModel {
    var date: String!
    var fel_vezeteknev: String!
    var fel_keresztnev: String!
    var ingatlan_varos: String!
    var ingatlan_utca: String!
    var hash: String!
    var uid: Int!
    
    
    
    required init(json: JSON) {
        date = json["date"].stringValue
        fel_vezeteknev = json["fel_vezeteknev"].stringValue
        fel_keresztnev = json["fel_keresztnev"].stringValue
        ingatlan_varos = json["ingatlan_varos"].stringValue
        ingatlan_utca = json["ingatlan_utca"].stringValue
        hash = json["hash"].stringValue
        uid = json["uid"].intValue
    }
}