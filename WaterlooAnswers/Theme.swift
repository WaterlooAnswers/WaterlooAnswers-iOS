//
//  Theme.swift
//  WaterlooAnswers
//
//  Created by Hicham Abou Jaoude on 2015-03-26.
//  Copyright (c) 2015 Hicham Abou Jaoude. All rights reserved.
//

import UIKit

class Theme {

    class func regularFont(size: CGFloat) -> UIFont {
        if let font = UIFont(name: "HelveticaNeue-Light", size: size) {
            return font;
        }
        return UIFont()
    }

    class func textColor() -> UIColor {
        return UIColor(red:0.15, green:0.15, blue:0.15, alpha:1)
    }

}




