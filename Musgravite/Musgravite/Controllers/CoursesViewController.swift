//
//  CoursesViewController.swift
//  Musgravite
//
//  Created by Fernando Martin Garcia Del Angel on 21/08/19.
//  Copyright © 2019 Aabo Technologies. All rights reserved.
//

import UIKit

class CoursesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Variables
    @IBOutlet weak var courseName: UILabel!
    @IBOutlet weak var courseCode: UILabel!
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: Buttons
    @IBAction func informationPressed(_ sender: Any) {
        
    }
    
    //MARK: Table View Controllers
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
