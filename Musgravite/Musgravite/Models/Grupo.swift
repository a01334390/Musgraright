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
    var estudiantes:[DocumentReference]?
    var proyecto:DocumentReference
    var horaInicio:Int?
    var duracion:Int?
    var numero:Int?
    var salon:DocumentReference?
    
    init(_ documentID:String, _ equipos:[DocumentReference],_ estudiantes:[DocumentReference],_ proyecto:DocumentReference, _ horaInicio:Int, _ duracion: Int,_ numero: Int,_ salon:DocumentReference){
        self.documentID = documentID
        self.equipos = equipos
        self.estudiantes = estudiantes
        self.horaInicio = horaInicio
        self.duracion = duracion
        self.numero = numero
        self.salon = salon
        self.proyecto = proyecto
    }
}
