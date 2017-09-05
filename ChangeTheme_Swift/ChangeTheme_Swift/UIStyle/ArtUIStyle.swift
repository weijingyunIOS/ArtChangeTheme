//
//  ArtUIStyle.swift
//  ChangeTheme_Swift
//
//  Created by weijingyun on 2017/9/5.
//  Copyright © 2017年 weijingyun. All rights reserved.
//

import UIKit

fileprivate let kArtUIStyleFontKey = "font"
fileprivate let kArtUIStyleColorKey = "color"

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
        super.init()
        setValuesForKeys(styleDic)
        do {
            var colorStr = try styleDic[kArtUIStyleColorKey].unwrap(tip: kArtUIStyleColorKey + "不存在") as! String
            colorStr = colorStr.replacingOccurrences(of: " ", with: "")
            let colorArray = colorStr.components(separatedBy: ",")
            var alpha = 1.0
            if colorArray.count == 2 {
                alpha = Double(colorArray.last!)!
            }
            saveColor = UIColor.art_color(hexString: colorArray.first!, alpha: CGFloat(alpha))
        } catch {
//            print(error)
        }
        
        do {
            let font = try styleDic[kArtUIStyleFontKey].unwrap(tip: kArtUIStyleFontKey + "不存在") as! NSNumber
            saveFont = UIFont.systemFont(ofSize: CGFloat(font.doubleValue))
        } catch {
//            print(error)
        }
    }
    
    init(imageDic : [String : AnyObject], imageString : String) {
        super.init()
        let manager = ArtUIStyleManager.share
        let toPath = imageDic["toPath"] as! String
        do {
            
            switch manager.styleType {
            case .Default:
                saveImage = UIImage.init(named: imageString)
                break
                
            case .Bundle:
                let bundle = try Bundle.init(path: try manager.stylePath.unwrap()).unwrap()
                saveImage = findImage(imageString: imageString, block: { (path) -> (String?) in
                   return bundle.path(forResource: path, ofType: "png", inDirectory: toPath)
                })
                break
                
            case .Path:
                let stylePath = try manager.stylePath.unwrap()
                saveImage = findImage(imageString: imageString, block: { (path) -> (String?) in
                    return stylePath + "/" + toPath + "/" + path + ".png"
                })
                break
                
            }
            
        } catch {
            saveImage = UIImage.init(named: imageString)
        }
    }
    
    func findImage(imageString : String, block : (_: String) -> (String?)) -> UIImage {
        var arrayM = [String]()
        let scale = NSInteger(UIScreen.main.scale)
        arrayM.append(String.init(stringInterpolationSegment:scale))
        for index in 1...3 {
            if scale != index {
                arrayM.append(String.init(stringInterpolationSegment: index))
            }
        }
        
        var image : UIImage?
        for scaleStr in arrayM {
            var imageStr = imageString
            if NSInteger(scaleStr) != 1 {
                imageStr = imageStr + "@" + scaleStr + "x"
            }
            let imagePath = block(imageStr)
            if imagePath != nil {
                image = UIImage.init(contentsOfFile: imagePath!)
            }
            if image != nil {
                break;
            }
        }
   
        if image == nil {
            assert(false,"未在资源中找到可用的图")
            image = UIImage.init(named: imageString)
        }
        return image!
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
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
