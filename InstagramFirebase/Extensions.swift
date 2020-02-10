//
//  Extensions.swift
//  InstagramFirebase
//
//  Created by HaroldDavidson on 2/4/20.
//  Copyright © 2020 HaroldDavidson. All rights reserved.
//

import UIKit

// simplifying UIColor.rgb. Removes the need to /255 and alpha value.
extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}
