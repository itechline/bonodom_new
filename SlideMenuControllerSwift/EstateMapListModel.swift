//
//  EstateMapListModel.swift
//  Bonodom
//
//  Created by Attila Dán on 2016. 07. 13..
//  Copyright © 2016. Itechline. All rights reserved.
//

import SwiftyJSON

class EstateMapListModel {
    var id: Int!
    var lat: Double!
    var lng: Double!
    
    
    
    
    required init(json: JSON) {
        id = json["ingatlan_id"].intValue
        lat = json["ingatlan_lat"].doubleValue
        lng = json["ingatlan_lng"].doubleValue
    }
}
