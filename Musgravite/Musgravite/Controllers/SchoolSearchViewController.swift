//
//  SchoolSearchViewController.swift
//  Musgravite
//
//  Created by Fernando Martin Garcia Del Angel on 6/24/19.
//  Copyright © 2019 Aabo Technologies. All rights reserved.
//

import UIKit
import SVProgressHUD

class SchoolSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var salones:[Salon]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        SVProgressHUD.show(withStatus: "Obteniendo salones...")
        FirebaseController.getClassroomData(completionBlock: ({(salones) in
            if salones != nil {
                self.salones = salones
            } else {
                fatalError("Application couldn't download this thingie")
            }
            SVProgressHUD.dismiss()
        }))
    }

    // MARK: Table View Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "RoomTVC", for: indexPath as IndexPath) as! RoomsTableViewCell
        cell.labname.text = "Lab"
        cell.buildingname.text = "202"
        return cell
    }
    
    //MARK: Collection View Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FloorsCVC", for: indexPath as IndexPath) as! FloorsCollectionViewCell
        cell.bigTitle.text = "Piso 1"
        return cell
    }
    
}
