//
//  Proyecto.swift
//  Musgravite
//
//  Created by Fernando Martin Garcia Del Angel on 6/20/19.
//  Copyright © 2019 Aabo Technologies. All rights reserved.
//

import Foundation
import FirebaseFirestore

class Proyecto {
    var documentID:String?
    var nombre:String?
    var metodologia:Any?
    var fase:Any?
    var descripcion:String?
    var tareas:[DocumentReference]?
    
    init(_ documentID:String,_ nombre:String,_ metodologia: Any,_ fase:Any,_ descripcion: String,_ tareas:[DocumentReference]){
        self.documentID = documentID
        self.nombre = nombre
        self.metodologia = metodologia
        self.fase = fase
        self.descripcion = descripcion
        self.tareas = tareas
    }
    
    func firestoreReady() -> [String: Any] {
        let dictionary: [String: Any] = [
            "nombre" : self.nombre!,
            "metodologia": self.metodologia!,
            "fase" : self.fase!,
            "descripcion" : self.descripcion!,
            "tareas" : self.tareas!
        ]
        return dictionary
    }
}
