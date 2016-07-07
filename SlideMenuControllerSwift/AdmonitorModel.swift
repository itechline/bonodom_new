//
//  AdmonitorModel.swift
//  Bonodom
//
//  Created by Attila Dán on 2016. 07. 07..
//  Copyright © 2016. Itechline. All rights reserved.
//

import SwiftyJSON

class AdmonitorModel {
    var id: Int!
    var name: String!
    var ingatlan_butorozott: Int!
    var ingatlan_lift: Int!
    var ingatlan_erkely: Int!
    var ingatlan_meret: Int!
    var ingatlan_szsz_min: Int!
    var ingatlan_szsz_max: Int!
    var ingatlan_emelet_max: Int!
    var ingatlan_emelet_min: Int!
    var ingatlan_allapot_id: Int!
    var ingatlan_tipus_id: Int!
    var ingatlan_energiatan_id: Int!
    var ingatlan_kilatas_id: Int!
    var ingatlan_parkolas_id: Int!
    var ingatlan_ar_max: String!
    var ingatlan_ar_min: String!
    var keyword: String!
    
    /*
     mon.setId(json_data.getInt("hir_id"));
     mon.setName(json_data.getString("name"));
     mon.setHasFurniture(json_data.getInt("ingatlan_butorozott"));
     mon.setElevator(json_data.getInt("ingatlan_lift"));
     mon.setBalcony(json_data.getInt("ingatlan_erkely"));
     mon.setSize(json_data.getInt("ingatlan_meret"));
     mon.setRoomsMin(json_data.getInt("ingatlan_szsz_min"));
     mon.setRoomsMax(json_data.getInt("ingatlan_szsz_max"));
     mon.setFloorsMax(json_data.getInt("ingatlan_emelet_max"));
     mon.setFloorsMin(json_data.getInt("ingatlan_emelet_min"));
     mon.setCondition(json_data.getInt("ingatlan_allapot_id"));
     mon.setType(json_data.getInt("ingatlan_tipus_id"));
     mon.setEtype(json_data.getInt("ingatlan_energiatan_id"));
     mon.setView(json_data.getInt("ingatlan_kilatas_id"));
     mon.setParking(json_data.getInt("ingatlan_parkolas_id"));
     mon.setPriceMax(json_data.getString("ingatlan_ar_max"));
     mon.setPriceMin(json_data.getString("ingatlan_ar_min"));
     mon.setSearch(json_data.getString("keyword"));
 */
    
    
    
    required init(json: JSON) {
        id = json["hir_id"].intValue
        name = json["name"].stringValue
        ingatlan_butorozott = json["ingatlan_butorozott"].intValue
        ingatlan_lift = json["ingatlan_lift"].intValue
        ingatlan_erkely = json["ingatlan_erkely"].intValue
        ingatlan_meret = json["ingatlan_meret"].intValue
        ingatlan_szsz_min = json["ingatlan_szsz_min"].intValue
        ingatlan_szsz_max = json["ingatlan_szsz_max"].intValue
        ingatlan_emelet_max = json["ingatlan_emelet_max"].intValue
        ingatlan_emelet_min = json["ingatlan_emelet_min"].intValue
        ingatlan_allapot_id = json["ingatlan_allapot_id"].intValue
        ingatlan_tipus_id = json["ingatlan_tipus_id"].intValue
        ingatlan_energiatan_id = json["ingatlan_energiatan_id"].intValue
        ingatlan_kilatas_id = json["ingatlan_kilatas_id"].intValue
        ingatlan_parkolas_id = json["ingatlan_parkolas_id"].intValue
        ingatlan_ar_max = json["ingatlan_ar_max"].stringValue
        ingatlan_ar_min = json["ingatlan_ar_min"].stringValue
        keyword = json["keyword"].stringValue
        
    }
}
