//
//  Equipo.swift
//  Musgravite
//
//  Created by Fernando Martin Garcia Del Angel on 6/18/19.
//  Copyright © 2019 Aabo Technologies. All rights reserved.
//

import Foundation

class Equipo {
    var documentID:String?
    var nombre:String?
    var integrantes:[String]?
    
    init(_ documentID:String,_ nombre: String,_ integrantes:[String]){
        self.documentID = documentID
        self.nombre = nombre
        self.integrantes = integrantes
    }
    
    func firestoreReady() -> [String:Any]{
        let dictionary: [String:Any] = [
            "nombre": self.nombre!,
            "integrantes": self.integrantes!
        ]
        return dictionary
    }
}
