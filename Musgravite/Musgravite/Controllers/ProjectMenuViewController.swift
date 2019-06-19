//
//  ProjectMenuViewController.swift
//  Musgravite
//
//  Created by Fernando Martin Garcia Del Angel on 6/18/19.
//  Copyright © 2019 Aabo Technologies. All rights reserved.
//

import UIKit
import SVProgressHUD

class ProjectMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        SVProgressHUD.show(withStatus: "Descargando salones")
        FirebaseController.getClassroomData(completionBlock: ({(salones) in
            SVProgressHUD.show(withStatus: "Descargando cursos")
            FirebaseController.getCourseData(salones![0].cursos![0], completionBlock: ({(curso) in
                SVProgressHUD.show(withStatus: "Descargando grupos")
                FirebaseController.getGroupData(curso!.grupos![0], completionBlock: ({(grupo) in
                    SVProgressHUD.show(withStatus: "Descargando equipos")
                    FirebaseController.getTeamData(grupo!.equipos![0], completionBlock: ({(equipo) in
                        print(equipo!.nombre as! String)
                    }))
                    SVProgressHUD.dismiss()
                }))
            }))
            
        }))
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
