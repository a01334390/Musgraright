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
    
    @IBOutlet weak var avatarButtonImage: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var greetingLabel: UILabel!
    
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
        avatarButtonImage.setRounded()
    }

    @IBAction func actionSheetAction(_ sender: Any) {
        let optionMenu = UIAlertController(title: nil, message: "Que deseas hacer?", preferredStyle: .actionSheet)
        let avatarAction = UIAlertAction(title: "Ir a ver mi Avatar", style: .default, handler:{ (UIAlertAction) in
            print("not yet")
        })
        let logOut = UIAlertAction(title: "Cerrar sesion", style: .destructive, handler:{ (UIAlertAction) in
            FirebaseController.logOut()
        })
        
        optionMenu.addAction(avatarAction)
        optionMenu.addAction(logOut)
        UIApplication.shared.keyWindow?.rootViewController?.present(optionMenu, animated: true, completion: nil)
    }
}
