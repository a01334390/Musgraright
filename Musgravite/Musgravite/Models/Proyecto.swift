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
    var metodologia:DocumentReference?
    var descripcion:String?
    
    init(_ documentID:String,_ nombre:String,_ metodologia: DocumentReference,_ descripcion: String){
        self.documentID = documentID
        self.nombre = nombre
        self.metodologia = metodologia
        self.descripcion = descripcion
    }
    
    func firestoreReady() -> [String: Any] {
        let dictionary: [String: Any] = [
            "nombre" : self.nombre!,
            "metodologia": self.metodologia!,
            "descripcion" : self.descripcion!
        ]
        return dictionary
    }
}
