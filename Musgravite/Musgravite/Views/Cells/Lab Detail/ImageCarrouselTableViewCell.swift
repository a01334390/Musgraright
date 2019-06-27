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
    var image360:String?
    private var slsimage:NSURL?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UINib.init(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCVC")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images?.count ?? 0 + (image360?.count ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCVC", for: indexPath) as! ImageCollectionViewCell
        if indexPath.item == 0 && image360 != nil {
            cell.imageType.text = "3D"
            cell.posterImage.sd_setImage(with: URL(string: image360!), placeholderImage: UIImage(named: "blueprint"))
        } else {
            cell.imageType.text = ""
            cell.posterImage.sd_setImage(with: URL(string: images![indexPath.item]), placeholderImage: UIImage(named: "blueprint"))
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if image360 != nil && indexPath.item == 0 {
           print("Wait for a hotfix")
        } else {
            let imageURL:URL = URL(string: (images?[indexPath.item])!)!
            NetworkActionsController.downloadImage(imageURL, completionBlock: ({(fileURL) in
                if fileURL == nil {
                    fatalError()
                } else {
                    let quickLookController = QLPreviewController()
                    quickLookController.dataSource = self
                    quickLookController.delegate = self
                    self.slsimage = fileURL
                    UIApplication.shared.keyWindow?.rootViewController!.present(quickLookController, animated: true)
                }
            }))
        }
        
        
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
