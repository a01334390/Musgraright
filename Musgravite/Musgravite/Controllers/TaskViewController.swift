//
//  TaskViewController.swift
//  Musgravite
//
//  Created by Fernando Martin Garcia Del Angel on 22/08/19.
//  Copyright © 2019 Aabo Technologies. All rights reserved.
//

import UIKit

class TaskViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: Outlets
    
    @IBOutlet weak var taskStatus: UIImageView!
    @IBOutlet weak var taskTitle: UILabel!
    @IBOutlet weak var daysRemaining: UILabel!
    @IBOutlet weak var taskDescription: UITextView!
    
    //Actions

    @IBAction func changeStatus(_ sender: Any) {
    }
    
    @IBAction func changeResponsible(_ sender: Any) {
    }
}
