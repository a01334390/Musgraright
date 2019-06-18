//
//  Extensions.swift
//  Musgravite
//
//  Created by Fernando Martin Garcia Del Angel on 6/17/19.
//  Copyright © 2019 Aabo Technologies. All rights reserved.
//

import UIKit

extension UIView {
    
}
extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static func mainGreen() -> UIColor {
        return UIColor.rgb(red: 109, green: 215, blue: 130)
    }
    
    static func mainBlue() -> UIColor {
        return UIColor.rgb(red: 135, green: 174, blue: 100)
    }
}
