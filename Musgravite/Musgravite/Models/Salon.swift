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
    var nombreCorto:String?
    
    init(_ documentID:String,_ nombre: String, _ cursos:[DocumentReference],_ edificio:String,_ numero:Int,_ tipo:Int) {
        self.documentID = documentID
        self.cursos = cursos
        self.edificio = edificio
        self.numero = numero
        self.tipo = tipo == 0 ? Tipo.Laboratorio : Tipo.Aula
        self.nombreCorto = nombre
        self.nombre = self.setClassroomName(nombre)
    }
    
    init(_ documentID:String,_ nombre: String,_ edificio:String,_ numero:Int,_ tipo:Int) {
        self.documentID = documentID
        self.edificio = edificio
        self.numero = numero
        self.tipo = tipo == 0 ? Tipo.Laboratorio : Tipo.Aula
        self.nombreCorto = nombre
        self.nombre = self.setClassroomName(nombre)
    }
    
    private func setClassroomName(_ nombre:String) -> String{
        return self.tipo == Tipo.Laboratorio ?
        "Laboratorio de \(nombre)" :
        "Aula de \(nombre)"
    }
    
}
