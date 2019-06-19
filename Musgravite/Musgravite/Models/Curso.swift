//
//  Course.swift
//  Musgravite
//
//  Created by Fernando Martin Garcia Del Angel on 6/18/19.
//  Copyright © 2019 Aabo Technologies. All rights reserved.
//

import Foundation
import FirebaseFirestore

class Curso {
     var documentID:String?
     var nombre:String?
     var grupos:[DocumentReference]?

    init(_ documentID:String, _ nombre:String,_ grupos:[DocumentReference]) {
        self.documentID = documentID
        self.nombre = nombre
        self.grupos = grupos
    }
    
}
