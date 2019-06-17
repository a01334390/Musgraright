//
//  ViewController.swift
//  Musgravite
//
//  Created by Fernando Martin Garcia Del Angel on 6/16/19.
//  Copyright © 2019 Aabo Technologies. All rights reserved.
//

import UIKit
import FirebaseUI

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func loginTapped(_ sender: Any) {
        // Get the default auth UI Object
        let authUI = FUIAuth.defaultAuthUI()
        guard authUI != nil else {
            return
        }
        // Set ourselves as the delegate
        authUI?.delegate = self
        authUI?.providers = [FUIEmailAuth()]
        // Get a reference to the auth UI view controller
        let authViewController = authUI!.authViewController()
        
        // Show it
        present(authViewController, animated: true, completion: nil)
    }
    
}

extension ViewController: FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        // Check if there was an error
        guard error == nil else {
            // Log the error
            print(error ?? "An error has occured in Musgravite")
            return
        }
        
        //authDataResult?.user.uid
        
        performSegue(withIdentifier: "goHome", sender: self)
    }
}

