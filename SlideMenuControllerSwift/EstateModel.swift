//
//  EstateModel.swift
//  Bonodom
//
//  Created by Attila Dán on 2016. 06. 08..
//  Copyright © 2016. Itechline. All rights reserved.
//

import SwiftyJSON

class EstateModel {
    var id: Int!
    var adress: String!
    var street: String!
    var description: String!
    var price: String!
    var size: String!
    var rooms: String!
    var pic: String!
    
    var ingatlan_szsz_id: String!
    var ingatlan_szsz: String!
    var ingatlan_parkolas_id: String!
    var mobil: String!
    var ingatlan_lift: String!
    var ingatlan_emelet_id: String!
    var ingatlan_parkolas: String!
    var ingatlan_title: String!
    var ingatlan_kilatas: String!
    var ingatlan_allapot_id: String!
    var ingatlan_varos: String!
    var ingatlan_energiatan_id: String!
    var ingatlan_butorozott: String!
    var ingatlan_tipus_id: String!
    var ingatlan_tipus: String!
    var ingatlan_kilatas_id: String!
    var vezeteknev: String!
    var keresztnev: String!
    var ingatlan_allapot: String!
    var ingatlan_ar: String!
    var kedvenc: Bool!
    var ing_e_type: String!
    var ingatlan_utca: String!
    var ingatlan_lat: String!
    var ingatlan_lng: String!
    var ingatlan_id: String!
    var ing_e_type_id: String!
    var ingatlan_rovidleiras: String!
    var ingatlan_futestipus: String!
    var ingatlan_emelet: String!
    var face: String!
    var ingatlan_erkely: String!
    var tipus: String!
    var ingatlan_energiatan: String!
    var ingatlan_futestipus_id: String!
    
    /*
     {
     "ingatlan_szsz_id" : "0",
     "ingatlan_szsz" : "",
     "ingatlan_parkolas_id" : "0",
     "mobil" : "06203232",
     "ingatlan_lift" : "0",
     "ingatlan_emelet_id" : "0",
     "ingatlan_parkolas" : "",
     "ingatlan_title" : "hsh",
     "ingatlan_kilatas" : "",
     "ingatlan_allapot_id" : "0",
     "ingatlan_varos" : "Debrecen",
     "ingatlan_energiatan_id" : "0",
     "ingatlan_butorozott" : "3",
     
     "ingatlan_tipus_id" : "0",
     "ingatlan_tipus" : "",
     "ingatlan_kilatas_id" : "0",
     "vezeteknev" : "Dan",
     "ingatlan_allapot" : "",
     "ingatlan_picture_url" : "",
     "ingatlan_ar" : "652",
     "kedvenc" : "false",
     "keresztnev" : "Attila",
     "ing_e_type" : "Eladó",
     "ingatlan_utca" : "Piac",
     "ingatlan_lng" : "",
     "ingatlan_id" : "259",
     "kepek" : [
     {
     "kepek_url" : "https:\/\/bonodom.com\/ing\/img\/1920_1080\/b33ea9ed248368cc1efd756e90f2bca2.png"
     },
     {
     "kepek_url" : "https:\/\/bonodom.com\/ing\/img\/1920_1080\/3c6eb37b34eef2ee71af45b7f3fef657.png"
     },
     {
     "kepek_url" : "https:\/\/bonodom.com\/ing\/img\/1920_1080\/89547ff2bd6e87ef8dde0b69d0111e33.png"
     }
     ],
     "ing_e_type_id" : "1",
     "ingatlan_rovidleiras" : "hshs",
     "ingatlan_futestipus" : "",
     "ingatlan_emelet" : "",
     "ingatlan_meret" : "88",
     "ingatlan_lat" : "",
     "face" : "",
     "ingatlan_erkely" : "0",
     "tipus" : "",
     "ingatlan_energiatan" : "",
     "ingatlan_futestipus_id" : "0"
     }
     */
    
    required init(json: JSON) {
        id = json["ingatlan_id"].intValue
        ingatlan_title = json["ingatlan_title"].stringValue
        adress = json["ingatlan_varos"].stringValue
        street = json["ingatlan_utca"].stringValue
        description = json["ingatlan_rovidleiras"].stringValue
        price = json["ingatlan_ar"].stringValue
        size = json["ingatlan_meret"].stringValue
        rooms = json["ingatlan_szsz_id"].stringValue
        keresztnev = json["keresztnev"].stringValue
        vezeteknev = json["vezeteknev"].stringValue
        ing_e_type = json["ing_e_type"].stringValue
        ing_e_type_id = json["ing_e_type_id"].stringValue
        ingatlan_futestipus_id = json["ingatlan_futestipus_id"].stringValue
        ingatlan_szsz_id = json["ingatlan_szsz_id"].stringValue
        ingatlan_parkolas_id = json["ingatlan_parkolas_id"].stringValue
        mobil = json["mobil"].stringValue
        ingatlan_lift = json["ingatlan_lift"].stringValue
        ingatlan_emelet_id = json["ingatlan_emelet_id"].stringValue
        ingatlan_allapot_id = json["ingatlan_allapot_id"].stringValue
        ingatlan_energiatan_id = json["ingatlan_energiatan_id"].stringValue
        ingatlan_butorozott = json["ingatlan_butorozott"].stringValue
        ingatlan_tipus_id = json["ingatlan_tipus_id"].stringValue
        ingatlan_kilatas_id = json["ingatlan_kilatas_id"].stringValue
        kedvenc = json["kedvenc"].boolValue
        ingatlan_lat = json["ingatlan_lat"].stringValue
        ingatlan_lng = json["ingatlan_lng"].stringValue
        
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
