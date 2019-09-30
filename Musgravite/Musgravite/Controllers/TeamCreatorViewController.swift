//
//  TeamCreatorViewController.swift
//  Musgravite
//
//  Created by Fernando Martin Garcia Del Angel on 22/08/19.
//  Copyright © 2019 Aabo Technologies. All rights reserved.
//

import UIKit
import SVProgressHUD
import FirebaseFirestore

class TeamCreatorViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    // MARK: Variables
    @IBOutlet weak var teammatesTable: UITableView!
    @IBOutlet weak var teamName: UITextField!
    var students:[Estudiante]?
    var studentsDR:[DocumentReference]?
    var group:Grupo?
    var limit = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        self.teammatesTable.delegate = self
        self.teammatesTable.dataSource = self
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    //MARK: Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students!.count
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentsTVC", for: indexPath)
        let dequeuablestudent = students![indexPath.item]
        cell.textLabel!.text = dequeuablestudent.nombre
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if let sr = tableView.indexPathsForSelectedRows {
            print(sr)
            if sr.count == limit {
                let alert = UIAlertController(title: "Oops!", message: "You're limited to \(self.limit) selections", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        return indexPath
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
        }

        if let sr = tableView.indexPathsForSelectedRows {
            print("didDiselectRowIndexPath selected rows:\(sr)")
        }
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }

        if let sr = tableView.indexPathsForSelectedRows {
            print("didDiselectRowIndexPath selected rows:\(sr)")
        }
    }
    
    //MARK: Actions
    @IBAction func createTeam(_ sender: Any){
        if teamName.text!.isEmpty {
            let alert = UIAlertController(title: "Empty", message: "Please create a project name", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        if teammatesTable.indexPathsForSelectedRows == nil {
            let alert = UIAlertController(title: "Empty", message: "Please add at least one team member", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        var selectedStudents:[DocumentReference] = []
        for row in teammatesTable.indexPathsForSelectedRows! {
            selectedStudents.append((self.studentsDR?[row[1]])!)
        }
        let team = Equipo("", teamName.text! , selectedStudents, [self.group!.proyecto])
       
        SVProgressHUD.show(withStatus: "Creating Team....")
        FirebaseController.addTeamToGroup(team, self.group!.documentID!, completionBlock: ({(happened) in
            if happened {
                SVProgressHUD.showInfo(withStatus: "Success!")
                SVProgressHUD.dismiss(withDelay: 3, completion: {
                    self.navigationController!.popViewController(animated: true)
                })
            } else {
               SVProgressHUD.showError(withStatus: "Error!\nCouldn't create team")
                SVProgressHUD.dismiss(withDelay: 3, completion: {
                })

            }
        }))
    }
    
}
