//
//  GroupViewController.swift
//  Musgravite
//
//  Created by Fernando Martin Garcia Del Angel on 21/08/19.
//  Copyright © 2019 Aabo Technologies. All rights reserved.
//

import UIKit

class GroupViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: Variables
    @IBOutlet weak var scheduleLabel: UILabel!
    @IBOutlet weak var teamsTable: UITableView!
    @IBOutlet weak var studentsCollection: UICollectionView!
    
    
    //MARK: Actions
    @IBAction func seeClassroom(_ sender: Any) {
        
    }
    
    
    
    //MARK: Students Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    //MARK: Teams Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
