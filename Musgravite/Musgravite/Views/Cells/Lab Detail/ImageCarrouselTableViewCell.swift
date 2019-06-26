//
//  ImageCarrouselTableViewCell.swift
//  Musgravite
//
//  Created by Fernando Martin Garcia Del Angel on 6/25/19.
//  Copyright © 2019 Aabo Technologies. All rights reserved.
//

import UIKit
import SDWebImage
import QuickLook

class ImageCarrouselTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, QLPreviewControllerDelegate, QLPreviewControllerDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var images:[String]?
    var viewController:LabDetailViewController?
    private var quickLookController = QLPreviewController()
    private var slsimage:NSURL?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UINib.init(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCVC")
        self.quickLookController.dataSource = self
        self.quickLookController.delegate = self
        

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCVC", for: indexPath) as! ImageCollectionViewCell
        cell.posterImage.sd_setImage(with: URL(string: images![indexPath.item]), placeholderImage: UIImage(named: "blueprint"))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let imageURL = URL(string: (images?[indexPath.item])!)!
        NetworkActionsController.downloadImage(imageURL, completionBlock: ({(fileURL) in
            if fileURL == nil {
                fatalError()
            } else {
                self.slsimage = fileURL
                self.viewController?.navigationController?.pushViewController(self.quickLookController, animated: true)
            }
        }))
    }
    
    //MARK: Quick Look Delegates
    
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        return slsimage!
    }
    
    func previewController(_ controller: QLPreviewController, shouldOpen url: URL, for item: QLPreviewItem) -> Bool {
        return true
    }
    
}
