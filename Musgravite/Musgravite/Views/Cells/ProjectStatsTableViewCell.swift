//
//  ProjectStatsTableViewCell.swift
//  Musgravite
//
//  Created by Fernando Martin Garcia Del Angel on 6/19/19.
//  Copyright © 2019 Aabo Technologies. All rights reserved.
//

import UIKit

class ProjectStatsTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var menuItems:[MenuItem]?
    
    //MARK: UITableViewCell Protocols
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UINib.init(nibName: "ProjectStatsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProjectStatsCVC")

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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProjectStatsCVC", for: indexPath as IndexPath) as! ProjectStatsCollectionViewCell
        cell.backgroundImage.image = menuItems![indexPath.item].image!
        cell.numberStat.text = menuItems![indexPath.item].itemDescription!
        cell.descriptionStat.text = menuItems![indexPath.item].title!
        return cell
    }
}
