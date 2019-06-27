//
//  LabDetailViewController.swift
//  Musgravite
//
//  Created by Fernando Martin Garcia Del Angel on 6/25/19.
//  Copyright © 2019 Aabo Technologies. All rights reserved.
//

import UIKit
import SDWebImage

class LabDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var selectedClassroom:Salon?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Table View Nibs
        self.tableView.register(UINib.init(nibName: "PosterTableViewCell", bundle: nil), forCellReuseIdentifier: "PosterTVC")
        self.tableView.register(UINib.init(nibName: "ImageCarrouselTableViewCell", bundle: nil), forCellReuseIdentifier: "ImageCarrouselTVC")
        self.tableView.register(UINib.init(nibName: "VideoTableViewCell", bundle: nil), forCellReuseIdentifier: "VideoTVC")
        self.tableView.register(UINib.init(nibName: "ResourcesTableViewCell", bundle: nil), forCellReuseIdentifier: "ResourcesTVC")
        // Big Title
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    //MARK: Table View Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedClassroom!.contents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dequedcontent = selectedClassroom?.contents[indexPath.item]
        switch(dequedcontent!.contentType) {
        case .poster :
            tableView.rowHeight = 296
            let cell = tableView.dequeueReusableCell(withIdentifier: "PosterTVC", for: indexPath) as! PosterTableViewCell
            cell.posterImage.sd_setImage(with: URL(string:dequedcontent!.posterImage), placeholderImage: UIImage(named: "blueprint"))
            cell.classroomName.text = dequedcontent?.classroomName
            cell.buildingName.text = "\(dequedcontent?.building ?? "") - \(dequedcontent?.buildnumb ?? 0)"
            return cell
            
        case .imageCarrousel:
            tableView.rowHeight = 380
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCarrouselTVC", for: indexPath) as! ImageCarrouselTableViewCell
            cell.images = dequedcontent?.images
            return cell
            
        case .videoCarrousel:
            tableView.rowHeight = 380
            let cell = tableView.dequeueReusableCell(withIdentifier: "VideoTVC", for: indexPath) as! VideoTableViewCell
            cell.videoURI = dequedcontent?.videos
            return cell
            
        case .documentCarrousel:
            tableView.rowHeight = 500
            let cell = tableView.dequeueReusableCell(withIdentifier: "ResourcesTVC", for: indexPath) as! ResourcesTableViewCell
            cell.documents = dequedcontent?.documents
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PosterTVC", for: indexPath) as! PosterTableViewCell
            cell.posterImage.sd_setImage(with: URL(string:"http://martinmolina.com.mx/201813/novus2018/Musgravite/pictures/dani.jpg"), placeholderImage: UIImage(named: "blueprint"))
            cell.classroomName.text = "wow"
            return cell
        }
    }
    

}
