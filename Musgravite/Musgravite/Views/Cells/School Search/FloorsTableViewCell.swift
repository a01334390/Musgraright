//
//  FloorsTableViewCell.swift
//  Musgravite
//
//  Created by Fernando Martin Garcia Del Angel on 6/24/19.
//  Copyright © 2019 Aabo Technologies. All rights reserved.
//

import UIKit

class FloorsTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var menuItems:[MenuItem]?
    var viewController:SchoolSearchVM?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        // Colection View Code
        self.collectionView.register(UINib.init(nibName: "FloorCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FloorsCVC")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: Collection View Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuItems?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FloorsCVC", for: indexPath as IndexPath) as! FloorCollectionViewCell
        cell.bigImage.image = menuItems![indexPath.item].image!
        cell.bigTitle.text = menuItems![indexPath.item].title!
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
    
    
}
