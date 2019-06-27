//
//  ResourcesModifiedTableViewCell.swift
//  Musgravite
//
//  Created by Fernando Martin Garcia Del Angel on 26/06/19.
//  Copyright © 2019 Aabo Technologies. All rights reserved.
//

import UIKit

class ResourcesModifiedTableViewCell: UITableViewCell {
    @IBOutlet weak var documentTitle: UILabel!
    @IBOutlet weak var documentExtension: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
