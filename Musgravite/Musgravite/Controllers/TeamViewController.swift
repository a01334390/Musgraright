//
//  TeamViewController.swift
//  Musgravite
//
//  Created by Fernando Martin Garcia Del Angel on 22/08/19.
//  Copyright © 2019 Aabo Technologies. All rights reserved.
//

import UIKit

class TeamViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: Variables
    
    @IBOutlet weak var phaseImage: UIImageView!
    @IBOutlet weak var tasksCollection: UICollectionView!
    @IBOutlet weak var yourTasksCollection: UICollectionView!
    
    // MARK: Tasks CV
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    // MARK: Actions
     @IBAction func changeTeamsSettings(_ sender: Any) {
        
     }
     
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}
