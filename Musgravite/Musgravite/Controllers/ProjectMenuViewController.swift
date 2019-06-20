//
//  ProjectMenuViewController.swift
//  Musgravite
//
//  Created by Fernando Martin Garcia Del Angel on 6/18/19.
//  Copyright © 2019 Aabo Technologies. All rights reserved.
//

import UIKit

class ProjectMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var statsItems:[Any]?
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
    }
    
    //MARK: UITableView Controller Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProjectMenuVM.getStatsElements().count == 0 ? 1 : 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (ProjectMenuVM.getStatsElements().count != 0 && indexPath.item == 0) {
            tableView.rowHeight = 200
            return tableView.dequeueReusableCell(withIdentifier: "ProjectStatsTVC", for: indexPath as IndexPath) as! ProjectStatsTableViewCell
        }
        
        if (ProjectMenuVM.getStatsElements().count != 0 && indexPath.item == 1) || (ProjectMenuVM.getStatsElements().count == 0) {
            tableView.rowHeight = CGFloat((Int((ProjectMenuVM.getMenuElements().count / 2)) * 250) + 20)
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectMenuTVC", for: indexPath as IndexPath) as! ProjectMenuTableViewCell
            cell.menuItems = ProjectMenuVM.getMenuElements()
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
