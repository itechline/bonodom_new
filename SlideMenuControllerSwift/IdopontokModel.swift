//
//  IdopontokModel.swift
//  Bonodom
//
//  Created by Attila Dán on 2016. 07. 15..
//  Copyright © 2016. Itechline. All rights reserved.
//

import SwiftyJSON

class IdopontokModel {
    var idopont: String!
    
    
    
    required init(json: JSON) {
        idopont = json["idopont"].stringValue
    }
}
