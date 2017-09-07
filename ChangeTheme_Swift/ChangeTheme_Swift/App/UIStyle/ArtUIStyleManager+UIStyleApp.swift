//
//  ArtUIStyleManager+UIStyleApp.swift
//  ChangeTheme_Swift
//
//  Created by weijingyun on 2017/9/5.
//  Copyright © 2017年 weijingyun. All rights reserved.
//

import UIKit

extension ArtUIStyleManager {
    
    func getStyleName_App() -> String! {
        return "AppStyle.plist"
    }
    
    func getHotReloaderStylePath_App() -> String! {
        return "/App/UIStyle/AppStyle.plist";
    }
    
}

extension ArtUIStyle {
    class func artAppStyle(styleKey : String) -> ArtUIStyle {
        return ArtUIStyleManager.artStyle(module: "App_Main", styleKey:styleKey)
    }
}

extension UIColor {
    class func artAppStyle(styleKey : String) -> UIColor {
        return ArtUIStyleManager.artStyle(module: "App_Main", styleKey:styleKey).color()
    }
}

extension UIFont {
    class func artAppStyle(styleKey : String) -> UIFont {
        return ArtUIStyleManager.artStyle(module: "App_Main", styleKey:styleKey).font()
    }
}

extension UIImage {
    class func artAppImage(imageString : String) -> UIImage {
        return ArtUIStyleManager.artImage(module: "App_Main", imageString: imageString).image()
    }
}
