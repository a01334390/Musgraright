//
//  Metodologia.swift
//  Musgravite
//
//  Created by Fernando Martin Garcia Del Angel on 14/10/19.
//  Copyright © 2019 Aabo Technologies. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct Herramienta {
    var laboratorio:DocumentReference?
    var libro:URL?
    var link:URL?
    var mooc:URL?
}

struct TareaMet {
    var nombre:String?
    var descripcion:String?
    var herramientas:Herramienta?
}

struct Etapa {
    var titulo:String?
    var descripcion:String?
    var tareas:[TareaMet]?
}

class Metodologia {
    var id:String?
    var nombre:String?
    var descripcion:String?
    var etapas:[Etapa]?
    
    init(_ id:String,_ nombre:String,_ descripcion:String,_ etapas:[Etapa]) {
        self.id = id
        self.nombre = nombre
        self.descripcion = descripcion
        self.etapas = etapas
    }
}
