//
//  EstateListModel.swift
//  Bonodom
//
//  Created by Attila Dán on 2016. 06. 06..
//  Copyright © 2016. Itechline. All rights reserved.
//
import SwiftyJSON

class EstateListModel {
    var adress: String!
    var street: String!
    var description: String!
    var price: String!
    var pic: String!
    
    required init(json: JSON) {
        adress = json["msg"].stringValue
        street = json["dsc"].stringValue
        description = json["price"].stringValue
        price = json["pic"].stringValue
        pic = json["pic"].stringValue
    }
}
