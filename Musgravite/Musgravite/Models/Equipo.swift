//
//  Equipo.swift
//  Musgravite
//
//  Created by Fernando Martin Garcia Del Angel on 6/18/19.
//  Copyright © 2019 Aabo Technologies. All rights reserved.
//

import Foundation
import FirebaseFirestore

class Equipo {
    var documentID:String?
    var nombre:String?
    var integrantes:[String]?
    var proyectos:[DocumentReference]?
    
    init(_ documentID:String,_ nombre: String,_ integrantes:[String], _ proyectos:[DocumentReference]){
        self.documentID = documentID
        self.nombre = nombre
        self.integrantes = integrantes
        self.proyectos = proyectos
    }
    
    func firestoreReady() -> [String:Any]{
        let dictionary: [String:Any] = [
            "nombre": self.nombre!,
            "integrantes": self.integrantes!,
            "proyectos" : self.proyectos!
        ]
        return dictionary
    }
}
