//
//  HomepageVM.swift
//  Musgravite
//
//  Created by Fernando Martin Garcia Del Angel on 6/17/19.
//  Copyright © 2019 Aabo Technologies. All rights reserved.
//

import UIKit
import BLTNBoard
import CoreLocation

public class HomepageVM {
    
    //MARK: Library variables
    
    
    //MARK: Helper functions
    
    /**
        Checks if this is the first time the App has been launched, otherwise, it doesn't do much
     */
    static func hasBeenLaunched() -> Bool{
        return UserDefaults.standard.bool(forKey: "launchedBefore")
    }
    
    static func getOnboardingPages() -> BLTNPageItem {
        return self.createRootPage()
    }
    
    static func getTodaysDate() -> String {
        let currentDate = Date()
        let dateFormat = DateFormatter()
        dateFormat.dateStyle = .medium
        return dateFormat.string(from: currentDate)
    }
    
    //MARK: BLTNBoard Page Items
    
    static func createRootPage() -> BLTNPageItem {
        let firstPage = BLTNPageItem(title: "Bienvenido a Musgravite")
        firstPage.image = UIImage(named: "bulletin-1")
        firstPage.descriptionText = "Descubre los laboratorios que existen en tu Campus y crea tu siguiente proyecto"
        firstPage.actionButtonTitle = "Empezar"
        firstPage.appearance.actionButtonTitleColor = .white
        firstPage.requiresCloseButton = false
        firstPage.isDismissable = false
        firstPage.actionHandler = { item in
            firstPage.next = createGetEmailPage()
            item.manager?.displayNextItem()
        }
        
        return firstPage
    }
    
    static func createGetEmailPage() -> BLTNPageItem {
        let page = TextFieldBulletinPage(title: "¿Cuál es tu correo electrónico?")
        page.isDismissable = false
        page.descriptionText = "Para empezar, requerimos tu correo electrónico"
        page.actionButtonTitle = "Continuar"
        
        page.textInputHandler = {(item,text) in
            item.manager?.displayActivityIndicator()
            FirebaseController.userIsRegistered(text!, completionBlock: ({(success) in
                page.next = createGetPasswordPage(!success, text!)
                item.manager?.displayNextItem()
            }))
        }
        return page
    }
    
    static func createGetPasswordPage(_ signup: Bool,_ email:String) -> BLTNPageItem {
        let page = PasswordFieldBulletinPage(title: "Ingresa tu contraseña")
        page.isDismissable = false
        if signup {
            page.descriptionText = "Ingresa una contraseña para crear tu perfil"
            page.actionButtonTitle = "Crear cuenta"
        } else {
            page.descriptionText = "Ingresa tu contraseña para iniciar sesion"
            page.actionButtonTitle = "Iniciar sesión"
        }
        
        page.textInputHandler = {(item,text) in
            item.manager?.displayActivityIndicator()
            if signup {
                FirebaseController.signUp(email, text!, completionBlock: ({ (success) in
                    if success {
                        page.next = createLocationServicesPage()
                    } else {
                        page.next = createErrorPage()
                    }
                    item.manager?.displayNextItem()
                }))
            } else {
                FirebaseController.signIn(email, text!, completionBlock: ({(success) in
                    if success {
                        page.next = createSuccessPage()
                    } else {
                        page.next = createErrorPage()
                    }
                    item.manager?.displayNextItem()
                }))
            }
            
        }
        return page
    }
    
    static func createSuccessPage() -> BLTNPageItem {
        let page = BLTNPageItem(title: "Configuracion completa")
        page.image = UIImage(named: "bulletin-2")
        page.imageAccessibilityLabel = "Checkmark"
        page.appearance.actionButtonColor = UIColor(red:0.04, green:0.40, blue:0.14, alpha:1.0)
        page.appearance.imageViewTintColor = UIColor(red:0.04, green:0.40, blue:0.14, alpha:1.0)
        page.appearance.actionButtonTitleColor = .white
        page.descriptionText = "Musgravite esta lista para usarse, ¡A crear algo nuevo!"
        page.actionButtonTitle = "Empecemos"
        page.requiresCloseButton = false
        page.isDismissable = true
        page.dismissalHandler = { item in
            UserDefaults.standard.set(true, forKey: "launchedBefore")
        }
        
        page.actionHandler = { item in
            UserDefaults.standard.set(true, forKey: "launchedBefore")
            item.manager?.dismissBulletin(animated: true)
        }
        
        return page
    
    }
    
    static func createErrorPage() -> BLTNPageItem {
        let page = BLTNPageItem(title: "Oops!")
        page.image = UIImage(named: "bulletin-3")
        page.imageAccessibilityLabel = "Cross"
        page.appearance.actionButtonColor = UIColor(red:1, green:0, blue:0, alpha:1.0)
        page.appearance.imageViewTintColor = UIColor(red:1, green:0, blue:0, alpha:1.0)
        page.appearance.actionButtonTitleColor = .white
        page.descriptionText = "Hubo un problema con la autenticación, vuelvelo a intentar"
        page.actionButtonTitle = "Vamos"
        page.requiresCloseButton = false
        page.isDismissable = false
        
        page.actionHandler = { item in
            item.manager?.popItem()
        }
        
        return page
    }
    
    static func createLocationServicesPage() -> BLTNPageItem {
        let locationManager = CLLocationManager()
        let firstPage = BLTNPageItem(title: "Servicios de Localizacion")
        firstPage.image = UIImage(named: "bulletin-4")
        firstPage.descriptionText = "Para personalizar tu experiencia necesitamos tu localizacion. Esta informacion sera enviada a nuestros servidores de forma anonima. Puedes cambiar de opinion mas adelante en las preferencias de la aplicacion."
        firstPage.actionButtonTitle = "Activar Localizacion"
        firstPage.alternativeButtonTitle = "Ahora no"
        firstPage.requiresCloseButton = false
        firstPage.isDismissable = false
        firstPage.appearance.shouldUseCompactDescriptionText = true
        firstPage.next = createSuccessPage()
        firstPage.actionHandler = { item in
            /* Request Location */
            locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
            item.manager?.displayNextItem()
        }
        firstPage.alternativeHandler = { item in
            item.manager?.displayNextItem()
        }
        return firstPage
    }
    
    //MARK: Main Menu Elements
    
    static func getMenuElements() -> [MainMenuItem] {
        var menuElements:[MainMenuItem]?
        //Menu Elements
        let images:[String] = ["blueprint"]
        let titles:[String] = ["Proyectos"]
        let description:[String] = ["Unete a un proyecto y crea tu siguiente innovacion"]
        let destinationSegues:[String] = ["HomeProject"]
        
        for index in stride(from: 0, to: images.count, by: 1) {
            let item = MainMenuItem(image: images[index], title: titles[index], itemDescription: description[index], destinationSegue: destinationSegues[index])
            if (menuElements?.append(item)) == nil {
                menuElements = [item]
            } else {
                menuElements?.append(item)
            }
        }
        
        return menuElements ?? [MainMenuItem(title: "Error", itemDescription: "No hay elementos a desplegar. Intentelo nuevamente mas tarde", destinationSegue: "")]
    }
    
}
