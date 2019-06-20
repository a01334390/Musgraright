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
    var menuItems:[MenuItem]?
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
        // Menu Items query
        menuItems = ProjectMenuVM.getMenuElements()
    }
    
    //MARK: UITableView Controller Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.item {
        case 0:
            tableView.rowHeight = 200
            return tableView.dequeueReusableCell(withIdentifier: "ProjectStatsTVC", for: indexPath as IndexPath) as! ProjectStatsTableViewCell
        case 1:
            tableView.rowHeight = CGFloat((Int((menuItems!.count / 2)) * 250) + 20)
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectMenuTVC", for: indexPath as IndexPath) as! ProjectMenuTableViewCell
            cell.menuItems = menuItems
            cell.viewController = self
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.item)
    }
    
    func printDebug(segueIdentifier:String){
        print(segueIdentifier)
    }
}
