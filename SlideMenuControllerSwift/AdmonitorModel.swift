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
    var fel_id: Int!
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
        fel_id = json["fel_id"].intValue
    }
}
