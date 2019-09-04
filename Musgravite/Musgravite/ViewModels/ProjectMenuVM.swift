//
//  ProjectMenuVM.swift
//  Musgravite
//
//  Created by Fernando Martin Garcia Del Angel on 6/18/19.
//  Copyright © 2019 Aabo Technologies. All rights reserved.
//

import Foundation

public class ProjectMenuVM {
    
    static let signedUser = FirebaseController.currentAuthenticatedUserMail()
    
    static let defaultVerticalItem = MenuItem(image: "blueprint",
                                              title: "I'm downloading data", itemDescription: "Let's wait a sec.", destinationSegue: "HomeProject", type: contentType.vertical)
    static let defaultHorizontalItem = MenuItem(image: "blueprint",
    title: "I'm downloading data", itemDescription: "Let's wait a sec.", destinationSegue: "HomeProject", type: contentType.vertical)
    
    //MARK: Menu Elements
    
    static func getAllMenuElements(completionBlock: @escaping(_ success: [MenuItem]) -> Void) {
        getMenuElements(completionBlock: ({(menuelems) in
            getStatsElements(completionBlock: ({(statelems) in
                completionBlock(menuelems + statelems)
            }))
        }))
    }
    
    static func getStatsElements(completionBlock: @escaping(_ success: [MenuItem]) -> Void) {
        var menuElements:[MenuItem]?
        FirebaseController.getStudentData(studentID: signedUser, completionBlock: ({(estudiante) in
            FirebaseController.getTareasData(estudiante!.tareas!, completionBlock: ({(tareas) in
                for tarea in tareas! {
                    let item = MenuItem(image: "blueprint", title: tarea.nombre!,
                                        itemDescription: "\(tarea.daysLeft()) days left",
                    destinationSegue: "HomeProject",
                    type: contentType.horizontal)
                    
                    if menuElements == nil {
                        menuElements = [item]
                    } else {
                        menuElements?.append(item)
                    }
                }
                completionBlock(menuElements!)
            }))
        }))
    }
    
    static func getMenuElements(completionBlock: @escaping(_ success: [MenuItem]) -> Void) {
        var menuElements:[MenuItem]?
        //Menu Elements
        FirebaseController.getStudentData(studentID: signedUser, completionBlock: ({(estudiante) in
            FirebaseController.getTareasData(estudiante!.tareas!, completionBlock: ({(tareas) in
                for tarea in tareas! {
                    let item = MenuItem(image: "blueprint", title: tarea.nombre!,
                                        itemDescription: "\(tarea.daysLeft()) days left",
                    destinationSegue: "HomeProject",
                    type: contentType.vertical)
                    
                    if menuElements == nil {
                        menuElements = [item]
                    } else {
                        menuElements?.append(item)
                    }
                }
                completionBlock(menuElements!)
            }))
        }))
    }
}
