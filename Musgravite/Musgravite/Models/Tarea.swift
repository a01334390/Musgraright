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
    var fechaInicio:Date?
    var fechaFin:Date?
    var fase:Any?
    var status:String?
    var responsable:DocumentReference?
    
    init(_ id:String,_ nombre:String,_ descripcion:String,_ fechaInicio:Date,_ fechaFin:Date,_ fase:Any,_ status:String,_ responsable:DocumentReference) {
        self.id = id
        self.nombre = nombre
        self.descripcion = descripcion
        self.fechaInicio = fechaInicio
        self.fechaFin = fechaFin
        self.fase = fase
        self.status = status
        self.responsable = responsable
    }
    
    func daysLeft() -> Int {
        let calendar = Calendar.current
        let date1 = calendar.startOfDay(for: fechaInicio ?? Date.init())
        let date2 = calendar.startOfDay(for: fechaFin ?? Date.init())
        let components = calendar.dateComponents([.day], from: date1, to: date2)
        return components.day ?? -1
    }
}
