//
//  LabDetailViewController.swift
//  Musgravite
//
//  Created by Fernando Martin Garcia Del Angel on 6/25/19.
//  Copyright © 2019 Aabo Technologies. All rights reserved.
//

import UIKit

class LabDetailViewController: UIViewController {

    var selectedClassroom:Salon?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = selectedClassroom!.nombreCorto?.localizedCapitalized
        // Do any additional setup after loading the view.
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
