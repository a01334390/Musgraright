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
    //MARK: Variables and Managers
    
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
    
    //MARK: Helper Functions
    /**
        Launches the Onboarding Experience and requests permission
     */
    private func launchOnboardingExperience() {
        bulletinManager = {
            let introPage = HomepageVM.createRootPage()
            return BLTNItemManager(rootItem: introPage)
        }()
        bulletinManager?.backgroundViewStyle = .dimmed
        bulletinManager?.showBulletin(above: self)
    }
}

