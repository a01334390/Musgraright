//
//  ViewController.swift
//  Musgravite
//
//  Created by Fernando Martin Garcia Del Angel on 6/16/19.
//  Copyright © 2019 Aabo Technologies. All rights reserved.
//

import UIKit
import BLTNBoard
import Firebase

class ViewController: UIViewController {
    //MARK: Variables and Managers
    
    var handle: AuthStateDidChangeListenerHandle?
    
    // BulletinBoard Manager
    var bulletinManager:BLTNItemManager?
    
    //MARK: UIView Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if !HomepageVM.hasBeenLaunched() {
            launchOnboardingExperience()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if user == nil {
                self.launchAuthenticationExperience()
            }
        }
    }
    
    //MARK: Helper Functions
    /**
        Launches the Onboarding Experience and requests permission
     */
    private func launchOnboardingExperience() {
        bulletinManager = {
            let introPage = HomepageVM.createRootPage()
            return BLTNItemManager(rootItem: introPage)
        }()
        bulletinManager?.backgroundViewStyle = .blurredLight
        bulletinManager?.showBulletin(above: self)
    }
    
    private func launchAuthenticationExperience() {
        bulletinManager = {
            let introPage = HomepageVM.createGetEmailPage()
            return BLTNItemManager(rootItem: introPage)
        }()
        bulletinManager?.backgroundViewStyle = .blurredLight
        bulletinManager?.showBulletin(above: self)
    }
    
}

