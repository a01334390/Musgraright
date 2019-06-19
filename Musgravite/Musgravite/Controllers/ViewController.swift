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

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    //MARK: Variables and Managers
    
    var handle: AuthStateDidChangeListenerHandle?
    var menuItems:[MainMenuItem]?
    @IBOutlet weak var topBar: TopBarSuperview!
    
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
        //Get Menu Items
        menuItems = HomepageVM.getMenuElements()
        // Firebase Authentication Listener
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if user == nil && HomepageVM.hasBeenLaunched() {
                self.launchAuthenticationExperience()
            }
        }
        // Get required information
        topBar.dateLabel.text = HomepageVM.getTodaysDate()
        // Remove the navigation Bar
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    //MARK: CollectionView Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuItems?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeScreenCollectionViewCell", for: indexPath) as! HomeScreenCollectionViewCell
        cell.bigImage.image = menuItems![indexPath.item].image
        cell.title.text = menuItems![indexPath.item].title
        cell.menuDescription.text = menuItems![indexPath.item].itemDescription
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: menuItems![indexPath.item].destinationSegue!, sender: self)
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

