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
    case Independiente
}

class Salon {
    var documentID:String?
    var cursos:[DocumentReference] = []
    var edificio:String?
    var numero:Int
    var tipo:Tipo?
    var nombre:String?
    var nombreCorto:String?
    var contents:[ContentElement] = []
    
    init(_ documentID:String,_ nombre: String, _ cursos:[DocumentReference] = [],_ edificio:String,_ numero:Int,_ tipo:Int, _ contents:[ContentElement] = []) {
        self.documentID = documentID
        self.cursos = cursos
        self.contents = contents
        self.edificio = edificio
        self.numero = numero
        self.tipo = tipo == 0 ? Tipo.Laboratorio : tipo == 1 ? Tipo.Aula : Tipo.Independiente
        self.nombreCorto = nombre
        self.nombre = self.setClassroomName(nombre)
    }
    
    private func setClassroomName(_ nombre:String) -> String{
        switch(self.tipo!) {
        case Tipo.Aula :
            return "Aula de \(nombre)"
        case Tipo.Laboratorio :
            return "Laboratorio de \(nombre)"
        case Tipo.Independiente :
            return nombre
        }
    }
    
}
