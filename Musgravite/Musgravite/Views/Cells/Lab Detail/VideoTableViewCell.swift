//
//  VideoTableViewCell.swift
//  Musgravite
//
//  Created by Fernando Martin Garcia Del Angel on 26/06/19.
//  Copyright © 2019 Aabo Technologies. All rights reserved.
//

import UIKit
import AVKit

class VideoTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
 
    @IBOutlet weak var visualMode: UISegmentedControl!
    @IBOutlet weak var collectionView: UICollectionView!
    var videoURI:[String]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        //Register NIB
        self.collectionView.register(UINib.init(nibName: "VideoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "VideoCVC")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: Collection View Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videoURI!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCVC", for: indexPath) as! VideoCollectionViewCell
        //Download the Thumbnail
        DispatchQueue.global(qos: .background).async {
            let dimage = self.downloadThumbnail(self.videoURI![indexPath.item])
            DispatchQueue.main.async {
                cell.posterImage.image = dimage
            }
        }
        cell.videoTitle.text = URL(string: self.videoURI![indexPath.item])?.lastPathComponent
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch(visualMode.selectedSegmentIndex){
        case 0:
            print("AR")
        case 1:
            let item:URL = URL(string: self.videoURI![indexPath.item])!
            let player = AVPlayer(url: item)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            UIApplication.shared.keyWindow?.rootViewController!.present(playerViewController, animated: true) {
                playerViewController.player!.play()
            }
        default:
            fatalError()
        }
    }
    
    func downloadThumbnail(_ path:String) -> UIImage {
        do {
            let asset = AVURLAsset(url: URL(string: path)! , options: nil)
            let imgGenerator = AVAssetImageGenerator(asset: asset)
            imgGenerator.appliesPreferredTrackTransform = true
            let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(value: 0, timescale: 1), actualTime: nil)
            let thumbnail = UIImage(cgImage: cgImage)
            return thumbnail
        } catch let error {
            print("*** Error generating thumbnail: \(error.localizedDescription)")
            return UIImage()
        }
    }
    
}
