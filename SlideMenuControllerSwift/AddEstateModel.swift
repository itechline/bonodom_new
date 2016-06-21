//
//  AddEstateModel.swift
//  Bonodom
//
//  Created by Attila Dán on 2016. 06. 21..
//  Copyright © 2016. Itechline. All rights reserved.
//

import Foundation

class AddEstateModel {
    var cim: String
    var varos: String
    var utca: String
    var leiras: String
    var ar: String
    var meret: String
    var etan: String
    var butor: String
    var kilatas: String
    var lift: String
    var futes: String
    var parkolas: String
    var erkely: String
    var tipus: String
    var emelet: String
    var allapot: String
    var szsz: String
    var lat: String
    var lng: String
    var e_type: String
    var zipcode: String
    
    
    init(cim: String, varos: String, utca: String, leiras: String, ar: String, meret: String, etan: String,
         butor: String, kilatas: String, lift: String, futes: String, parkolas: String, erkely: String,
         tipus: String, emelet: String, allapot: String, szsz: String, lat: String, lng: String,
         e_type: String, zipcode: String) {
        self.cim = cim
        self.varos = varos
        self.utca = utca
        self.leiras = leiras
        self.ar = ar
        self.meret = meret
        self.etan = etan
        self.butor = butor
        self.kilatas = kilatas
        self.lift = lift
        self.futes = futes
        self.parkolas = parkolas
        self.erkely = erkely
        self.tipus = tipus
        self.emelet = emelet
        self.allapot = allapot
        self.szsz = szsz
        self.lat = lat
        self.lng = lng
        self.e_type = e_type
        self.zipcode = zipcode
    }
    
}
