//
//  SpinnerModel.swift
//  Bonodom
//
//  Created by Attila Dán on 2016. 06. 15..
//  Copyright © 2016. Itechline. All rights reserved.
//

//
//  EstateListModel.swift
//  Bonodom
//
//  Created by Attila Dán on 2016. 06. 06..
//  Copyright © 2016. Itechline. All rights reserved.
//
import SwiftyJSON

class SpinnerModel {
    var value: String!
    var display: String!
    
    
    
    required init(json: JSON, type: String) {
        display = json[type + "_val"].stringValue
        if(display.isEmpty) {
           display = json[type + "_name"].stringValue
        }
        value = json[type + "_id"].stringValue
        
        if (display.isEmpty && value.isEmpty) {
            display = json["nev"].stringValue
            value = json["id"].stringValue
        }
       
    }
}

