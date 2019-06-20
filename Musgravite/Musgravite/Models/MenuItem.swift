//
//  MainMenuItem.swift
//  Musgravite
//
//  Created by Fernando Martin Garcia Del Angel on 6/18/19.
//  Copyright © 2019 Aabo Technologies. All rights reserved.
//

import UIKit

enum contentType {
    case horizontal
    case vertical
}

class MenuItem {
    //MARK: Private Variables
    var image:UIImage?
    var title:String?
    var itemDescription:String?
    var destinationSegue:String?
    var type:contentType
    //MARK: Public Variables
    
    init(image:String, title:String, itemDescription:String = "", destinationSegue:String, type:contentType){
        self.image = UIImage(named: image)
        self.title = title
        self.itemDescription = itemDescription
        self.destinationSegue = destinationSegue
        self.type = type
    }
    
    init(title:String,itemDescription:String = "", destinationSegue:String, type:contentType){
        self.image = UIImage(named: "blueprint")
        self.title = title
        self.itemDescription = itemDescription
        self.destinationSegue = destinationSegue
        self.type = type
    }
}
