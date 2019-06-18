//
//  ViewController.swift
//  Musgravite
//
//  Created by Fernando Martin Garcia Del Angel on 6/16/19.
//  Copyright © 2019 Aabo Technologies. All rights reserved.
//

import UIKit
import BLTNBoard

class ViewController: UIViewController {
    
    func createOnboardingUsername() -> BLTNPageItem {
        let firstPage = BLTNPageItem(title: "Bienvenido a Musgravite")
        firstPage.image = UIImage(named: "buletin-1")
        firstPage.descriptionText = "Descubre los laboratorios que existen en CEDETEC y crea tu siguiente innovacion"
        firstPage.actionButtonTitle = "Configurar"
        firstPage.appearance.actionButtonTitleColor = .white
        firstPage.appearance.actionButtonColor = .purple
        firstPage.alternativeButtonTitle = "Ahora no"
        firstPage.requiresCloseButton = false
        firstPage.isDismissable = false
//        firstPage.next = createOnboardingUsername()
        firstPage.actionHandler = { item in
//            self.selection.selectionChanged()
            item.manager?.displayNextItem()
        }
        firstPage.alternativeHandler = { item in
//            self.selection.selectionChanged()
            item.manager?.dismissBulletin(animated: true)
        }
        print("ok")
        return firstPage
    }
    
    /* Bulletin board */
    lazy var bulletinManager: BLTNItemManager = {
        let introPage = createOnboardingUsername()
        print("ok")
        return BLTNItemManager(rootItem: introPage)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        bulletinManager.backgroundViewStyle = .dimmed
        bulletinManager.showBulletin(above: self)
    }
}

