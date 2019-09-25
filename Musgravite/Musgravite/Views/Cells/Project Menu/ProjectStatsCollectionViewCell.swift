//
//  ProjectStatsCollectionViewCell.swift
//  Musgravite
//
//  Created by Fernando Martin Garcia Del Angel on 6/19/19.
//  Copyright © 2019 Aabo Technologies. All rights reserved.
//

import UIKit

class ProjectStatsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var numberStat: UILabel!
    @IBOutlet weak var descriptionStat: UILabel!
    @IBOutlet var courseName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
