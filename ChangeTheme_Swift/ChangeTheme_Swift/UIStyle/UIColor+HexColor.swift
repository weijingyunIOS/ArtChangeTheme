//
//  UIColor+HexColor.swift
//  ChangeTheme_Swift
//
//  Created by weijingyun on 2017/9/5.
//  Copyright © 2017年 weijingyun. All rights reserved.
//

import UIKit
extension UIColor {
    class func art_color(hexString : String, alpha : CGFloat) -> UIColor {
        var hexNum: UInt32 = 0x0
        Scanner.init(string: hexString).scanHexInt32(&hexNum)
        return UIColor.art_color(RGBHex: hexNum, alpha: alpha)
    }
    
    class func art_color(RGBHex : UInt32, alpha : CGFloat) -> UIColor {
        let r = (RGBHex >> 16) & 0xFF;
        let g = (RGBHex >> 8) & 0xFF;
        let b = RGBHex & 0xFF;
        
        return UIColor.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: alpha)
    }
    
}
