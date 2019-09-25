//
//  Estudiante.swift
//  Musgravite
//
//  Created by Fernando Martin Garcia Del Angel on 01/09/19.
//  Copyright © 2019 Aabo Technologies. All rights reserved.
//

import Foundation
import FirebaseFirestore

class Estudiante {
    var id:String?
    var mail:String?
    var nombre:String?
    var apellidos:String?
    var matricula:String?
    var equipos:[DocumentReference]?
    var proyectos:[DocumentReference]?
    var grupos:[DocumentReference]?
    var tareas:[DocumentReference]?
    var cursos:[DocumentReference]?
    
    init(_ id:String,_ mail:String,_ nombre:String,_ apellidos:String,_ matricula: String,_ equipos:[DocumentReference],_ proyectos:[DocumentReference],_ grupos:[DocumentReference],_ tareas:[DocumentReference], _ cursos:[DocumentReference]) {
        self.id = id
        self.mail = mail
        self.nombre = nombre
        self.apellidos = apellidos
        self.matricula = matricula
        self.equipos = equipos
        self.proyectos = proyectos
        self.grupos = grupos
        self.tareas = tareas
        self.cursos = cursos
    }
}
