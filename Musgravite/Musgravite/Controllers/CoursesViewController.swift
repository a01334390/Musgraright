//
//  CoursesViewController.swift
//  Musgravite
//
//  Created by Fernando Martin Garcia Del Angel on 21/08/19.
//  Copyright © 2019 Aabo Technologies. All rights reserved.
//

import UIKit
import FirebaseFirestore
import SVProgressHUD

class CoursesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Variables
    @IBOutlet weak var courseName: UILabel!
    @IBOutlet weak var courseCode: UILabel!
    @IBOutlet weak var tableview: UITableView!
    
    var course:Curso?
    var groups:[Grupo] = []
    private var selectedGroup:Grupo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableview.delegate = self
        self.tableview.dataSource = self
        prepareUIParameters()
    }
    
    private func ref2String(documents: [DocumentReference]) -> [String]{
        if documents.isEmpty {
            return []
        }
        var strings:[String] = []
        for document in documents {
            strings.append(document.documentID)
        }
        return strings
    }
    
    override func viewWillAppear(_ animated: Bool) {
        FirebaseController.getGroupsInCourse(ref2String(documents: course!.grupos!), completionBlock: ({(grupos) in
            self.groups = grupos!
            self.tableview.reloadData()
        }))
    }
    
    //MARK: Buttons
    @IBAction func informationPressed(_ sender: Any) {
        
    }
    
    //MARK: Table View Controllers
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "simpleTVC", for: indexPath)
        cell.textLabel!.text = groups[indexPath.item].documentID
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SVProgressHUD.show(withStatus: "Descargando informacion del grupo...")
        FirebaseController.getGroupData(groups[indexPath.item].documentID!, completionBlock: ({(group) in
            SVProgressHUD.dismiss()
            self.selectedGroup = group
            self.performSegue(withIdentifier: "CourseGroup", sender: self)
        }))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch(segue.identifier){
        case "CourseGroup":
            let groupVC = segue.destination as! GroupViewController
            groupVC.group = self.selectedGroup
            break
        default:
            fatalError()
        }
    }
    
    private func prepareUIParameters(){
        courseName.text = course!.nombre
        courseCode.text = course!.documentID
    }
}
