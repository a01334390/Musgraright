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
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var tableView: UITableView!
    var salones:[Salon] = SchoolSearchVM.getDummyClassroom()
    var salonests:[Salon] = SchoolSearchVM.getDummyClassroom()
    var pisos:[Int] = [1]
    var selectedFloor = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Firebase Classroom Download
        SVProgressHUD.show(withStatus: "Obteniendo salones...")
        FirebaseController.getClassroomData(completionBlock: ({(salones) in
            if salones != nil {
                self.salones = salones!
                self.filterClassrooms()
                self.tableView.reloadData()
                self.pisos = SchoolSearchVM.getFloors(salones!)
                self.collectionView.reloadData()
            } else {
                fatalError("Application couldn't download this thingie")
            }
            SVProgressHUD.dismiss()
        })
        )
        // Navigation Bar UI Setup
        self.setupNavigationBar()
    }

    // MARK: Table View Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return salonests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "RoomTVC", for: indexPath as IndexPath) as! RoomsTableViewCell
        cell.labname.text = salonests[indexPath.item].nombre
        cell.buildingname.text = "\(salonests[indexPath.item].edificio ?? "")-\(salonests[indexPath.item].numero)"
        return cell
    }
    
    //MARK: Collection View Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pisos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FloorsCVC", for: indexPath as IndexPath) as! FloorsCollectionViewCell
        cell.bigTitle.text = "Piso \(pisos[indexPath.item])"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedFloor = pisos[indexPath.item]
        filterClassrooms()
    }
    
    //MARK: Other methods
    private func filterClassrooms(){
        self.salonests = self.salones.filter{SchoolSearchVM.getFloorNumber($0) == selectedFloor}
        self.tableView.reloadData()
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
    }
    
}
