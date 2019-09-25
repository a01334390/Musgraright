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
    var nombreProfesor:String?
    var semestre:String?
    var grupos:[DocumentReference]?
    var salones:[DocumentReference]?

    init(_ documentID:String, _ nombre:String,_ nombreProfesor:String,_ semestre:String, _ grupos:[DocumentReference],_ salones:[DocumentReference]) {
        self.documentID = documentID
        self.nombre = nombre
        self.nombreProfesor = nombreProfesor
        self.semestre = semestre
        self.grupos = grupos
        self.salones = salones
    }
    
}
