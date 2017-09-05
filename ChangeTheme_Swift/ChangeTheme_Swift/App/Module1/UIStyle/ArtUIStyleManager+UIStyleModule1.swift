//
//  ArtUIStyleManager+UIStyleModule1.swift
//  ChangeTheme_Swift
//
//  Created by weijingyun on 2017/9/4.
//  Copyright © 2017年 weijingyun. All rights reserved.
//

import UIKit

extension ArtUIStyleManager {
    
    func getStyleName_Module1() -> String! {
        return "Module1Style.plist"
    }
    
    func getHotReloaderStylePath_Module1() -> String! {
        return "/App/Module1/UIStyle/Module1Style.plist";
    }
    
}

extension ArtUIStyle {
    class func artModule1Style(styleKey : String) -> ArtUIStyle {
        return ArtUIStyleManager.artStyle(module: "Module1", styleKey:styleKey)
    }
}

extension UIColor {
    class func artModule1Style(styleKey : String) -> UIColor {
        return ArtUIStyleManager.artStyle(module: "Module1", styleKey:styleKey).color()
    }
}

extension UIFont {
    class func artModule1Style(styleKey : String) -> UIFont {
        return ArtUIStyleManager.artStyle(module: "Module1", styleKey:styleKey).font()
    }
}

extension UIImage {
    class func artModule1Image(imageString : String) -> UIImage {
        return ArtUIStyleManager.artImage(module: "Module1", imageString: imageString).image()
    }
}
