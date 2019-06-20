//
//  ProjectMenuVM.swift
//  Musgravite
//
//  Created by Fernando Martin Garcia Del Angel on 6/18/19.
//  Copyright © 2019 Aabo Technologies. All rights reserved.
//

import Foundation

public class ProjectMenuVM {
    
    //MARK: Menu Elements
    
    static func getAllMenuElements() -> [MenuItem] {
        return getMenuElements() + getStatsElements()
    }
    
    static func getStatsElements() -> [MenuItem] {
        var menuElements:[MenuItem]?
        let menu:[String:[String:String]] = [
            "0": [
                "image" : "blueprint",
                "title" : "Tareas terminadas a tiempo",
                "description" : "25",
                "destinationSegue" : "HomeProject"
            ],
            "1" : [
                "image" : "blueprint",
                "title" : "Equipos de trabajo",
                "description" : "42",
                "destinationSegue" : "HomeProject"
            ],
            "2" : [
                "image" : "blueprint",
                "title" : "Horas antes a terminar",
                "description" : "43",
                "destinationSegue" : "HomeProject"
            ]
        ]
        for index in stride(from: 0, to: menu.count, by: 1) {
            let item = MenuItem(image: menu[String(index)]!["image"]!,
                                title: menu[String(index)]!["title"]!,
                                itemDescription: menu[String(index)]!["description"]!,
                                destinationSegue: menu[String(index)]!["destinationSegue"]!, type: contentType.horizontal)
            if menuElements == nil {
                menuElements = [item]
            } else {
                menuElements?.append(item)
            }
        }
        
        return menuElements ?? [MenuItem(title: "Error", itemDescription: "No hay elementos a desplegar. Intentelo nuevamente mas tarde", destinationSegue: "", type: contentType.horizontal)]
    }
    
    static func getMenuElements() -> [MenuItem] {
        var menuElements:[MenuItem]?
        //Menu Elements
        let menu:[String:[String:String]] = [
            "0": [
                "image" : "blueprint",
                "title" : "Crea un nuevo proyecto",
                "destinationSegue" : "HomeProject"
            ],
            "1" : [
                "image" : "blueprint",
                "title" : "Ve tus proyectos actuales",
                "destinationSegue" : "HomeProject"
            ],
            "2" : [
                "image" : "blueprint",
                "title" : "Ve tus tareas actuales",
                "destinationSegue" : "HomeProject"
            ],
            "3" : [
                "image" : "blueprint",
                "title" : "Pide ayuda a un profesor",
                "destinationSegue" : "HomeProject"
            ]
        ]
        for index in stride(from: 0, to: menu.count, by: 1) {
            let item = MenuItem(image: menu[String(index)]!["image"]!,
                                title: menu[String(index)]!["title"]!,
                                destinationSegue: menu[String(index)]!["destinationSegue"]!, type: contentType.vertical)
            if menuElements == nil {
                menuElements = [item]
            } else {
                menuElements?.append(item)
            }
        }
        
        return menuElements ?? [MenuItem(title: "Error", itemDescription: "No hay elementos a desplegar. Intentelo nuevamente mas tarde", destinationSegue: "", type: contentType.vertical)]
    }
}
