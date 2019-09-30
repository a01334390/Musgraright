//
//  GroupViewController.swift
//  Musgravite
//
//  Created by Fernando Martin Garcia Del Angel on 21/08/19.
//  Copyright © 2019 Aabo Technologies. All rights reserved.
//

import UIKit
import SVProgressHUD
import FirebaseFirestore

class GroupViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var studentsCV: UICollectionView!
    @IBOutlet weak var teamsTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.studentsCV.delegate = self
        self.studentsCV.dataSource = self
        self.teamsTV.delegate = self
        self.teamsTV.dataSource = self
        setupStaticData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupDynamicData()
    }
    
    //MARK: Variables
    @IBOutlet weak var scheduleLabel: UILabel!
    @IBOutlet weak var teamsTable: UITableView!
    @IBOutlet weak var studentsCollection: UICollectionView!
    
    var group:Grupo?
    var selectedSalon:Salon?
    var students:[Estudiante] = []
    var teams:[Equipo] = []
    
    private func setupStaticData(){
        self.title = "Grupo \(self.group!.numero ?? 1)"
    }
    
    private func setupDynamicData(){
        SVProgressHUD.show(withStatus: "Descargando informacion de equipos...")
        FirebaseController.getTeamsInCourse(self.group!.equipos!, completionBlock: ({(teams) in
            self.teams = teams!
            self.teamsTV.reloadData()
            SVProgressHUD.show(withStatus: "Descargando informacion de estudiantes...")
            FirebaseController.getStudentsInCourse(self.group!.estudiantes!, completionBlock: ({(students) in
                self.students = students!
                print(students!.count)
                self.studentsCV.reloadData()
                SVProgressHUD.dismiss()
            }))
        }))
        
    }
    
    
    //MARK: Actions
    
    @IBAction func addTeam(_ sender: Any) {
        self.performSegue(withIdentifier: "GroupTeamCreation", sender: self)
    }
    
    @IBAction func seeClassroom(_ sender: Any) {
        SVProgressHUD.show(withStatus: "Descargando salon...")
        FirebaseController.getClassData(group!.salon!.documentID, completionBlock: ({(salon) in
            SVProgressHUD.dismiss()
            self.selectedSalon = salon
            self.performSegue(withIdentifier: "GroupClassroom", sender: self)
        }))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch(segue.identifier){
        case "GroupClassroom":
            let classroomVC = segue.destination as! LabDetailViewController
            classroomVC.selectedClassroom = self.selectedSalon
        case "GroupTeamCreation":
            let creatorVC = segue.destination as! TeamCreatorViewController
            let result = selectableStudents()
            creatorVC.students = result.0
            creatorVC.studentsDR = result.1
            creatorVC.group = self.group
        default:
            print("Not implemented")
        }
    }
    
    private func selectableStudents() -> ([Estudiante],[DocumentReference]) {
        var selectable:[DocumentReference] = []
        var selectableStudent:[Estudiante] = []
        for student in group!.estudiantes! {
            for team in teams {
                if !(team.integrantes?.contains(student))! {
                    selectable.append(student)
                }
            }
        }
        for student in self.students {
            for id in selectable {
                if student.id == id.documentID {
                    selectableStudent.append(student)
                }
            }
        }
        
        return (selectableStudent,selectable)
    }
    
    //MARK: Students Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.students.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "studentCVC", for: indexPath) as! StudentCollectionViewCell
        cell.name.text = self.students[indexPath.item].nombre
        return cell
    }
    
    //MARK: Teams Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "teamsTVC", for: indexPath)
        cell.textLabel?.text = self.teams[indexPath.item].nombre
        return cell
    }
}
