//
//  Salon.swift
//  Musgravite
//
//  Created by Fernando Martin Garcia Del Angel on 6/19/19.
//  Copyright © 2019 Aabo Technologies. All rights reserved.
//

import Foundation
import FirebaseFirestore

enum Tipo {
    case Laboratorio
    case Aula
}

class Salon {
    var documentID:String?
    var cursos:[DocumentReference]?
    var edificio:String?
    var numero:Int
    var tipo:Tipo?
    var nombre:String?
    
    init(_ documentID:String,_ nombre: String, _ cursos:[DocumentReference],_ edificio:String,_ numero:Int,_ tipo:Int) {
        self.documentID = documentID
        self.nombre = nombre
        self.cursos = cursos
        self.edificio = edificio
        self.numero = numero
        self.tipo = tipo == 0 ? Tipo.Laboratorio : Tipo.Aula
    }
    
    init(_ documentID:String,_ nombre: String,_ edificio:String,_ numero:Int,_ tipo:Int) {
        self.documentID = documentID
        self.nombre = nombre
        self.edificio = edificio
        self.numero = numero
        self.tipo = tipo == 0 ? Tipo.Laboratorio : Tipo.Aula
    }
    
}
