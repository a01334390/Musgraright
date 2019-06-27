//
//  SchoolSearchVM.swift
//  Musgravite
//
//  Created by Fernando Martin Garcia Del Angel on 6/24/19.
//  Copyright © 2019 Aabo Technologies. All rights reserved.
//

import Foundation
import FirebaseFirestore

class SchoolSearchVM {
    
    static func getFloorNumber(_ salon:Salon) -> Int {
        return salon.numero / 100
    }
    
    static func getFloors(_ salones:[Salon]) -> [Int] {
        var floors:[Int] = []
        for salon in salones {
            let floor = self.getFloorNumber(salon)
            if !floors.contains(floor) {
                floors.append(floor)
            }
        }
        return floors
    }
    
    static func extractAndBreakFilenameInComponents(fileURL: URL) -> (fileName: String, fileExtension: String) {
        // Break the NSURL path into its components and create a new array with those components.
        let fileURLParts = fileURL.path.components(separatedBy: "/")
        
        // Get the file name from the last position of the array above.
        let fileName = fileURLParts.last
        
        // Break the file name into its components based on the period symbol (".").
        let filenameParts = fileName?.components(separatedBy: ".")
        
        // Return a tuple.
        return (filenameParts![0], filenameParts![1])
    }
    
    static func getSectionsFromResources(documents:[String]) -> [String] {
        var filetypes:[String]?
        for document in documents {
            let filedata = self.extractAndBreakFilenameInComponents(fileURL: URL(string: document)!)
            var type:String = ""
            switch filedata.1 {
            case "pdf", "doc", "docx", "pages", "rtf":
                type = "Texts"
            case "xlsx", "xls", "numbers", "csv" :
                type = "Spreadsheets"
            case "ppt", "pptx", "keynote" :
                type = "Presentations"
            case "usdz" :
                type = "Models"
            default:
                type = "Unknown Filetype"
            }
            
            if !(filetypes?.contains(type))! {
                filetypes!.append(type)
            }
        }
        
        return filetypes!
    }
}
