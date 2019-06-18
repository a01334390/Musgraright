//
//  MainMenuItem.swift
//  Musgravite
//
//  Created by Fernando Martin Garcia Del Angel on 6/18/19.
//  Copyright © 2019 Aabo Technologies. All rights reserved.
//

import UIKit

class MainMenuItem {
    //MARK: Private Variables
    var image:UIImage?
    var title:String?
    var itemDescription:String?
    //MARK: Public Variables
    private var cell:UICollectionViewCell?
    
    init(image:String, title:String, itemDescription:String){
        self.image = UIImage(named: image)
        self.title = title
        self.itemDescription = itemDescription
    }
    
    init(title:String,itemDescription:String){
        self.image = UIImage(named: "blueprint")
        self.title = title
        self.itemDescription = itemDescription
    }
}
