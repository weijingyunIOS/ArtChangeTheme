//
//  ArtUIStyle.swift
//  ChangeTheme_Swift
//
//  Created by weijingyun on 2017/9/5.
//  Copyright © 2017年 weijingyun. All rights reserved.
//

import UIKit

class ArtUIStyle: NSObject {
    
    fileprivate var saveImage : UIImage?
    fileprivate var saveColor : UIColor?
    fileprivate var saveFont  : UIFont?
    let top             = 0.0
    let left            = 0.0
    let bottom          = 0.0
    let right           = 0.0
    let height          = 0.0
    let centerXOffset   = 0.0
    let centerYOffset   = 0.0
    
    init(styleDic : [String : AnyObject]) {
        
    }
    
    init(imageDic : [String : AnyObject], imageString : String) {
        
    }
    
    func color() -> UIColor {
        assert(saveColor != nil, "请检查")
        return saveColor!
    }
    
    func image() -> UIImage {
        assert(saveImage != nil, "请检查")
        return saveImage!
    }
    
    func font() -> UIFont {
        assert(saveFont != nil, "请检查")
        return saveFont!
    }
}

extension ArtUIStyle {
    class func artStyle(module : String, styleKey : String) -> ArtUIStyle {
        return ArtUIStyleManager.artStyle(module: module, styleKey:styleKey)
    }
}

extension UIColor {
    class func artStyle(module : String, styleKey : String) -> UIColor {
        return ArtUIStyleManager.artStyle(module: module, styleKey:styleKey).color()
    }
}

extension UIFont {
    class func artStyle(module : String, styleKey : String) -> UIFont {
        return ArtUIStyleManager.artStyle(module: module, styleKey:styleKey).font()
    }
}

extension UIImage {
    class func artImage(module : String, imageString : String) -> UIImage {
        return ArtUIStyleManager.artImage(module: module, imageString: imageString).image()
    }
}
