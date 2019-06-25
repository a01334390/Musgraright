//
//  ProjectMenuTableViewCell.swift
//  Musgravite
//
//  Created by Fernando Martin Garcia Del Angel on 6/19/19.
//  Copyright © 2019 Aabo Technologies. All rights reserved.
//

import UIKit

class ProjectMenuTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var menuItems:[MenuItem]?
    var viewController:ProjectMenuViewController?
    
    //MARK: UITableView Protocols
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UINib.init(nibName: "ProjectMenuCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProjectMenuCVC")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: UICollectionView Protocols
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuItems?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProjectMenuCVC", for: indexPath as IndexPath) as! ProjectMenuCollectionViewCell
        cell.bigImage.image = menuItems![indexPath.item].image!
        cell.title.text = menuItems![indexPath.item].title!
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.viewController!.printDebug(segueIdentifier: menuItems![indexPath.item].destinationSegue! + " \(indexPath.item)")
    }
}
