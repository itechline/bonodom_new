//
//  EstateModel.swift
//  Bonodom
//
//  Created by Attila Dán on 2016. 06. 08..
//  Copyright © 2016. Itechline. All rights reserved.
//

import SwiftyJSON

class EstateModel {
    //var id: Int!
    var adress: String!
    var street: String!
    var description: String!
    var price: String!
    var size: String!
    var rooms: String!
    var pic: String!
    
    
    /*
     ingatlan_kilatas_id
     ingatlan_id
     ingatlan_hash
    -ingatlan_szsz_id
    -ingatlan_rovidleiras
     ingatlan_futestipus_id
     ingatlan_lift
     ingatlan_tipus_id
    -kepek -> kepek_url
     ingatlan_title
    -ingatlan_varos
     kedvenc
     ingatlan_butorozott
     ing_e_type_id
     ingatlan_e_type_id
    -ingatlan_meret
    -ingatlan_utca
     ingatlan_picture_url
     ingatlan_energiatan_id
     ingatlan_erkely
     ingatlan_hsz
     ingatlan_emelet_id
     ingatlan_allapot_id
    -ingatlan_ar
     ingatlan_parkolas_id
 */
    
    required init(json: JSON) {
        //id = json["ingatlan_id"].intValue
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
            //pic.append(picArray.1["kepek_url"].stringValue)
        }
        if (pic == nil) {
            pic = ""
        }
    }
}
