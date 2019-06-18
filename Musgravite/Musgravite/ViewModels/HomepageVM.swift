//
//  HomepageVM.swift
//  Musgravite
//
//  Created by Fernando Martin Garcia Del Angel on 6/17/19.
//  Copyright © 2019 Aabo Technologies. All rights reserved.
//

import UIKit
import BLTNBoard

public class HomepageVM {
    
    /**
        Checks if this is the first time the App has been launched, otherwise, it doesn't do much
     */
    static func hasBeenLaunched() -> Bool{
        return UserDefaults.standard.bool(forKey: "launchedBefore")
    }
    
    static func getOnboardingPages() -> BLTNPageItem {
        return self.createRootPage()
    }
    
    //MARK: BLTNBoard Page Items
    
    static func createRootPage() -> BLTNPageItem {
        let firstPage = BLTNPageItem(title: "Bienvenido a Musgravite")
        firstPage.image = UIImage(named: "bulletin-1")
        firstPage.descriptionText = "Descubre los laboratorios que existen en tu Campus y crea tu siguiente proyecto"
        firstPage.actionButtonTitle = "Crear cuenta"
        firstPage.appearance.actionButtonTitleColor = .white
        firstPage.appearance.actionButtonColor = UIColor.mainGreen()
        firstPage.alternativeButtonTitle = "Iniciar sesión"
        firstPage.requiresCloseButton = false
        firstPage.isDismissable = false
        firstPage.actionHandler = { item in
            item.manager?.displayNextItem()
        }
        firstPage.alternativeHandler = { item in
            item.manager?.displayNextItem()
        }
        
        return firstPage
    }
}
