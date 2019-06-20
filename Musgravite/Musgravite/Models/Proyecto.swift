//
//  Proyecto.swift
//  Musgravite
//
//  Created by Fernando Martin Garcia Del Angel on 6/20/19.
//  Copyright © 2019 Aabo Technologies. All rights reserved.
//

import Foundation

class Proyecto {
    var documentID:String?
    var nombre:String?
    
    init(_ documentID:String,_ nombre:String){
        self.documentID = documentID
        self.nombre = nombre
    }
}
