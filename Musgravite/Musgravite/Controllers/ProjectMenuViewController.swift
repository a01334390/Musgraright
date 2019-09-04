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
    
    @IBOutlet weak var tableView: UITableView!
    var statsItems:[Any]?
    var statselems:[MenuItem]?
    var menuelems:[MenuItem]?
    //MARK: UIView Controller Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // TableView Custom Cells
        self.tableView.register(UINib.init(nibName: "ProjectStatsTableViewCell", bundle: nil), forCellReuseIdentifier: "ProjectStatsTVC")
        self.tableView.register(UINib.init(nibName: "ProjectMenuTableViewCell", bundle: nil), forCellReuseIdentifier: "ProjectMenuTVC")
        
        SVProgressHUD.show(withStatus: "Downloading your tasks...")
        ProjectMenuVM.getStatsElements(completionBlock: ({(statselements) in
            SVProgressHUD.show(withStatus: "Downloading your projects...")
            ProjectMenuVM.getMenuElements(completionBlock: ({(menuelems) in
                SVProgressHUD.dismiss()
                
            }))
        }))
    }
    
    //MARK: UITableView Controller Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statselems!.count == 0 ? 1 : 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (statselems!.count != 0 && indexPath.item == 0) {
            tableView.rowHeight = 280
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectStatsTVC", for: indexPath as IndexPath) as! ProjectStatsTableViewCell
            cell.menuItems = statselems
            return cell
        }
        
        if (statselems!.count != 0 && indexPath.item == 1) || (statselems!.count == 0) {
            tableView.rowHeight = 295
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectMenuTVC", for: indexPath as IndexPath) as! ProjectMenuTableViewCell
            cell.menuItems = menuelems
            cell.viewController = self
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.item)
    }
    
    func printDebug(segueIdentifier:String){
        print(segueIdentifier)
    }
}
