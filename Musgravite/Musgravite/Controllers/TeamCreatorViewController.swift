//
//  TeamCreatorViewController.swift
//  Musgravite
//
//  Created by Fernando Martin Garcia Del Angel on 22/08/19.
//  Copyright © 2019 Aabo Technologies. All rights reserved.
//

import UIKit

class TeamCreatorViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    // MARK: Variables
    @IBOutlet weak var teammatesTable: UITableView!
    @IBOutlet weak var teamName: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return 0
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           return UITableViewCell()
       }
    
    //MARK: Actions
    @IBAction func createTeam(_ sender: Any) {
        
    }
    
}
