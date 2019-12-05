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
    var cursos:[String] = ["No se han encontrado cursos..."]
    var selectedCourse:Curso?
    
    @IBOutlet weak var grupoTV: UITableView!
    @IBOutlet weak var equiposTV: UITableView!
    @IBOutlet weak var cursosTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.grupoTV.dataSource = self
        self.grupoTV.delegate = self
        grupoTV.register(UITableViewCell.self, forCellReuseIdentifier: "simpleTVC")
        equiposTV.register(UITableViewCell.self, forCellReuseIdentifier: "simpleTVC")
        cursosTV.register(UITableViewCell.self, forCellReuseIdentifier: "simpleTVC")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        SVProgressHUD.show(withStatus: "Obteniendo la informacion del estudiante...")
        FirebaseController.getStudentData(studentID: FirebaseController.currentAuthenticatedUserMail().lowercased(), completionBlock: ({(estudiante) in
            SVProgressHUD.show(withStatus: "Obteniendo los grupos del estudiante...")
            if((estudiante?.grupos!.count)! > 0){
                self.grupos.removeAll()
            }
            
            for grupo in estudiante!.grupos! {
                self.grupos.append(grupo.documentID)
            }
            
            if((estudiante?.cursos!.count)! > 0) {
                self.cursos.removeAll()
            }
            
            for curso in estudiante!.cursos! {
                self.cursos.append(curso.documentID)
            }
            
            SVProgressHUD.show(withStatus: "Obteniendo los equipos del estudiante...")
            if((estudiante?.equipos!.count)! > 0) {
                self.equipos.removeAll()
            }
            for equipo in estudiante!.equipos! {
                self.equipos.append(equipo.documentID)
            }
            self.grupoTV.reloadData()
            self.equiposTV.reloadData()
            self.cursosTV.reloadData()
            SVProgressHUD.dismiss()
        }))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(tableView){
            case self.equiposTV:
                return equipos.count
        case self.grupoTV:
            return grupos.count
        case self.cursosTV:
            return cursos.count
        default:
            fatalError()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "simpleTVC",for: indexPath) as UITableViewCell
        switch(tableView){
            case self.equiposTV:
                    cell.textLabel?.text = equipos[indexPath.item]
                    return cell
            case self.grupoTV:
                cell.textLabel?.text = grupos[indexPath.item]
                return cell
            case self.cursosTV:
                cell.textLabel?.text = cursos[indexPath.item]
                return cell
            default:
                fatalError()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch(tableView){
            case self.equiposTV:
                   print()
            case self.grupoTV:
                print()
            case self.cursosTV:
                SVProgressHUD.show(withStatus: "Descargando informacion del curso...")
                FirebaseController.getCourseData(cursos[indexPath.item], completionBlock: ({(curso) in
                    SVProgressHUD.dismiss()
                    self.selectedCourse = curso
                    self.performSegue(withIdentifier: "ProjectCourse", sender: self)
                }))
            default:
                fatalError()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch(segue.identifier){
        case "ProjectCourse":
            let courseVC = segue.destination as! CoursesViewController
            courseVC.course = selectedCourse
        default:
            fatalError()
        }
    }
}
