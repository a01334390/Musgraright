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
                                destinationSegue: menu[String(index)]!["destinationSegue"]!)
            if menuElements == nil {
                menuElements = [item]
            } else {
                menuElements?.append(item)
            }
        }
        
        return menuElements ?? [MenuItem(title: "Error", itemDescription: "No hay elementos a desplegar. Intentelo nuevamente mas tarde", destinationSegue: "")]
    }
}
