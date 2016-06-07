//
//  EstateListModel.swift
//  Bonodom
//
//  Created by Attila Dán on 2016. 06. 06..
//  Copyright © 2016. Itechline. All rights reserved.
//
import SwiftyJSON

class EstateListModel {
    var id: Int!
    var adress: String!
    var street: String!
    var description: String!
    var price: String!
    var size: String!
    var rooms: String!
    var pic: String!
    
    required init(json: JSON) {
        id = json["ingatlan_id"].intValue
        adress = json["ingatlan_varos"].stringValue
        street = json["ingatlan_utca"].stringValue
        description = json["ingatlan_rovidleiras"].stringValue
        price = json["ingatlan_ar"].stringValue
        size = json["ingatlan_meret"].stringValue
        rooms = json["ingatlan_szsz_id"].stringValue
        
        for picArray in json["kepek"] {
            print ("PICTURE")
            print(picArray.1["kepek_url"].stringValue)
            pic = picArray.1["kepek_url"].stringValue
        }
        if (pic == nil) {
            pic = ""
        }
    }
}
