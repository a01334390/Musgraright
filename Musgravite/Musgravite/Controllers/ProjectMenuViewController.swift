//
//  ProjectMenuViewController.swift
//  Musgravite
//
//  Created by Fernando Martin Garcia Del Angel on 6/18/19.
//  Copyright © 2019 Aabo Technologies. All rights reserved.
//

import UIKit
import SVProgressHUD

class ProjectMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var equipos:[String] = ["No se han encontrado equipos..."]
    var grupos:[String] = ["No se han encontrado grupos..."]
    
    @IBOutlet weak var grupoTV: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.grupoTV.dataSource = self
        self.grupoTV.delegate = self
        grupoTV.register(UITableViewCell.self, forCellReuseIdentifier: "simpleTVC")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        SVProgressHUD.show(withStatus: "Obteniendo la informacion del estudiante...")
        FirebaseController.getStudentData(studentID: FirebaseController.currentAuthenticatedUserMail(), completionBlock: ({(estudiante) in
            SVProgressHUD.show(withStatus: "Obteniendo los grupos del estudiante...")
            if((estudiante?.grupos!.count)! > 0){
                self.grupos.removeAll()
            }
            
            for grupo in estudiante!.grupos! {
                self.grupos.append(grupo.documentID)
            }
            
            SVProgressHUD.show(withStatus: "Obteniendo los equipos del estudiante...")
            if((estudiante?.equipos!.count)! > 0) {
                self.equipos.removeAll()
            }
            for equipo in estudiante!.equipos! {
                self.equipos.append(equipo.documentID)
            }
            self.grupoTV.reloadData()
            SVProgressHUD.dismiss()
        }))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return equipos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "simpleTVC",for: indexPath) as UITableViewCell
        cell.textLabel?.text = equipos[indexPath.item]
        return cell
    }
}
