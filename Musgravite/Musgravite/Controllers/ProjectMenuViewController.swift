//
//  ProjectMenuViewController.swift
//  Musgravite
//
//  Created by Fernando Martin Garcia Del Angel on 6/18/19.
//  Copyright © 2019 Aabo Technologies. All rights reserved.
//

import UIKit
import SVProgressHUD

class ProjectMenuViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var statselems:[MenuItem] = ProjectMenuVM.defaultVerticalItem
    var menuelems:[MenuItem] =  ProjectMenuVM.defaultHorizontalItem
    //MARK: UIView Controller Methods
    @IBOutlet weak var tasksVC: UICollectionView!
    @IBOutlet weak var projectsVC: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tasksVC.delegate = self
        projectsVC.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        SVProgressHUD.show(withStatus: "Downloading your tasks...")
        ProjectMenuVM.getStatsElements(completionBlock: ({(statselements) in
            SVProgressHUD.show(withStatus: "Downloading your projects...")
            ProjectMenuVM.getMenuElements(completionBlock: ({(menuelems) in
                self.statselems = statselements
                self.menuelems = menuelems
                tasksVC.reloadData()
                projectsVC.reloadData()
                SVProgressHUD.dismiss()
            }))
        }))
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case self.tasksVC:
            return statselems.count
        case self.projectsVC:
            return menuelems.count
        default:
            fatalError()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case self.tasksVC:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProjectStatsCVC", for: indexPath as IndexPath) as! ProjectStatsCollectionViewCell
            cell.backgroundImage.image = menuelems[indexPath.item].image!
            cell.numberStat.text = menuelems[indexPath.item].itemDescription!
            cell.descriptionStat.text = menuelems[indexPath.item].title!
            return cell
        case self.projectsVC:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCVC", for: indexPath as IndexPath) as! VideoCollectionViewCell
            cell.posterImage.image = statselems[indexPath.item].image!
            cell.videoTitle.text = statselems[indexPath.item].title!
            cell.filetype.text = statselems[indexPath.item].itemDescription!
            return cell
        default:
            fatalError()
        }
    }
    
    //MARK: UITableView Controller Methods
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return statselems!.count == 0 ? 1 : 2
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if (statselems!.count != 0 && indexPath.item == 0) {
//            tableView.rowHeight = 280
//            let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectStatsTVC", for: indexPath as IndexPath) as! ProjectStatsTableViewCell
//            cell.menuItems = statselems
//            return cell
////        }
//
//        if (statselems!.count != 0 && indexPath.item == 1) || (statselems!.count == 0) {
//            tableView.rowHeight = 295
//            let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectMenuTVC", for: indexPath as IndexPath) as! ProjectMenuTableViewCell
//            cell.menuItems = menuelems
//            cell.viewController = self
//            return cell
//        }
//
//        return UITableViewCell()
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(indexPath.item)
//    }
//
//    func printDebug(segueIdentifier:String){
//        print(segueIdentifier)
//    }
}
