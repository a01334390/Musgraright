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
}
