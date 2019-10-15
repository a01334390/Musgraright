//
//  Tarea.swift
//  Musgravite
//
//  Created by Fernando Martin Garcia Del Angel on 01/09/19.
//  Copyright © 2019 Aabo Technologies. All rights reserved.
//

import Foundation
import FirebaseFirestore

class Tarea {
    var id:String?
    var nombre:String?
    var descripcion:String?
    var fechaFin:Date?
    var fase:String?
    var status:String?
    var responsable:String?
    
    init(_ id:String,_ nombre:String,_ descripcion:String,_ fechaFin:Date,_ fase:String, _ status:String,_ responsable:String) {
        self.id = id
        self.nombre = nombre
        self.descripcion = descripcion
        self.fechaFin = fechaFin
        self.fase = fase
        self.status = status
        self.responsable = responsable
    }
}
