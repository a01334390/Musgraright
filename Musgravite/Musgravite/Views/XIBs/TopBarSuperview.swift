//
//  TopBarSuperview.swift
//  Musgravite
//
//  Created by Fernando Martin Garcia Del Angel on 6/18/19.
//  Copyright © 2019 Aabo Technologies. All rights reserved.
//

import UIKit

class TopBarSuperview: UIView {
    
    //MARK: Variables and Outlets
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var avatarLabel: UIImageView!
    
    @IBOutlet var contentView: UIView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInitializer()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInitializer()
    }
    
    private func commonInitializer() {
        Bundle.main.loadNibNamed("TopBar", owner: self, options: nil)
        contentView.fixInView(self)
    }

}
