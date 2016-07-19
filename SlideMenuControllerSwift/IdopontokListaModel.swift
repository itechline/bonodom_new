//
//  IdopontokListaModel.swift
//  Bonodom
//
//  Created by Attila Dán on 2016. 07. 19..
//  Copyright © 2016. Itechline. All rights reserved.
//

import SwiftyJSON

class IdopontokListaModel {
    var hours: Int!
    var minutes: Int!
    var foglalt: Bool!
    
    
    required init(h: Int, m: Int, fogl: Bool) {
        hours = h
        minutes = m
        foglalt = fogl
    }
}
