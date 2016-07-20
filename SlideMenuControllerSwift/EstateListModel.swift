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
    var e_type: Int!
    var fav: Bool!
    var hashString: String!
    var balcony: Int!
    var furniture: Int!
    var parking: Int!
    
    var energiatan_id: Int!
    var kilatas_id: Int!
    var futes_id: Int!
    var tipus_id: Int!
    var emelet_id: Int!
    var allapot_id: Int!
    var szsz_id: Int!
    var lift_id: Int!
    
    var house_number: String!
    var city_id: Int!
    
    var title: String!
    
    
    
    
    required init(json: JSON) {
        id = json["ingatlan_id"].intValue
        adress = json["ingatlan_varos"].stringValue
        street = json["ingatlan_utca"].stringValue
        description = json["ingatlan_rovidleiras"].stringValue
        price = json["ingatlan_ar"].stringValue
        size = json["ingatlan_meret"].stringValue
        rooms = json["ingatlan_szsz_id"].stringValue
        e_type = json["ingatlan_e_type_id"].intValue
        fav = json["kedvenc"].boolValue
        hashString = json["ingatlan_hash"].stringValue
        
        balcony = json["ingatlan_erkely"].intValue
        furniture = json["ingatlan_butorozott"].intValue
        parking = json["ingatlan_parkolas_id"].intValue
        
        
        energiatan_id = json["ingatlan_energiatan_id"].intValue
        kilatas_id = json["ingatlan_kilatas_id"].intValue
        futes_id = json["ingatlan_futestipus_id"].intValue
        tipus_id = json["ingatlan_tipus_id"].intValue
        emelet_id = json["ingatlan_emelet_id"].intValue
        allapot_id = json["ingatlan_allapot_id"].intValue
        szsz_id = json["ingatlan_szsz_id"].intValue
        lift_id = json["ingatlan_lift"].intValue
        
        house_number = json["ingatlan_hsz"].stringValue
        city_id = json["ingatlan_varos_id"].intValue
        
        title = json["ingatlan_title"].stringValue
        
        
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
