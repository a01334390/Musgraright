//
//  TeamViewController.swift
//  Musgravite
//
//  Created by Fernando Martin Garcia Del Angel on 22/08/19.
//  Copyright © 2019 Aabo Technologies. All rights reserved.
//

import UIKit
import SVProgressHUD
import FirebaseFirestore

class TeamViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var team:Equipo?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tasksCollection.delegate = self
        self.tasksCollection.dataSource = self
        self.yourTasksCollection.delegate = self
        self.yourTasksCollection.dataSource = self
        setupStaticData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupDynamicData()
    }
    
    // MARK: Variables
    
    @IBOutlet weak var phaseImage: UIImageView!
    @IBOutlet weak var tasksCollection: UICollectionView!
    @IBOutlet weak var yourTasksCollection: UICollectionView!
    
    var metodology: Metodologia?
    var project: Proyecto?
    var selectedTask: Tarea?
    var teamTasks: [Tarea] = []
    var ownTasks: [Tarea] = []
    var student: Estudiante?
    
    private func setupDynamicData(){
        SVProgressHUD.show(withStatus: "Descargando informacion de tareas...")
        FirebaseController.getMetodologiaData(self.metodology!.id!, completionBlock: ({(met) in
            self.teamTasks = (met?.TareaMet2Tarea())!
            self.tasksCollection.reloadData()
            SVProgressHUD.show(withStatus: "Descargando informacion de tareas personales...")
            FirebaseController.getStudentData(studentID: FirebaseController.currentAuthenticatedUserMail(), completionBlock: ({(student) in
                self.student = student
                FirebaseController.getTareasData(student!.tareas!, completionBlock: ({(tareas) in
                    self.ownTasks = tareas!
                    self.yourTasksCollection.reloadData()
                    SVProgressHUD.dismiss()
                }))
            }))
        }))
        
    }
    
    func setupStaticData(){
        self.title = self.team?.nombre
    }
    
    // MARK: Tasks CV
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView.restorationIdentifier == "teamT" ? self.teamTasks.count : self.ownTasks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let aux = collectionView.restorationIdentifier == "teamT"
        var cell: StudentCollectionViewCell
        if aux {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamtasks", for: indexPath) as! StudentCollectionViewCell
            cell.name.text = self.teamTasks[indexPath.item].nombre
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "owntasks", for: indexPath) as! StudentCollectionViewCell
            cell.name.text = self.ownTasks[indexPath.item].nombre
        }
        return cell
    }
    
    // MARK: Actions
     @IBAction func changeTeamsSettings(_ sender: Any) {
        
     }
     
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let taskVC = segue.destination as! TaskViewController
        taskVC.task = self.selectedTask
    }
}
