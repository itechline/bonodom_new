//
//  IdopontokByDateModel.swift
//  Bonodom
//
//  Created by Attila Dán on 2016. 07. 15..
//  Copyright © 2016. Itechline. All rights reserved.
//

import SwiftyJSON

class IdopontokByDateModel {
    var id: Int!
    var ingatlan_id: Int!
    var datum: String!
    var status: Int!
    var fel_id: Int!
    
    
    required init(json: JSON) {
        id = json["idopont_id"].intValue
        ingatlan_id = json["idopont_ingatlan_id"].intValue
        datum = json["idopont_bejelentkezes"].stringValue
        status = json["idopont_statusz"].intValue
        fel_id = json["fel_id"].intValue
    }
}