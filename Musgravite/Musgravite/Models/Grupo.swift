//
//  Grupo.swift
//  Musgravite
//
//  Created by Fernando Martin Garcia Del Angel on 6/18/19.
//  Copyright © 2019 Aabo Technologies. All rights reserved.
//

import Foundation
import FirebaseFirestore

class Grupo {
    var documentID:String?
    var equipos:[DocumentReference]?
    var horaInicio:Int?
    var duracion:Int?
    
    init(_ documentID:String, _ equipos:[DocumentReference],_ horaInicio:Int, _ duracion: Int){
        self.documentID = documentID
        self.equipos = equipos
        self.horaInicio = horaInicio
        self.duracion = duracion
    }
}
