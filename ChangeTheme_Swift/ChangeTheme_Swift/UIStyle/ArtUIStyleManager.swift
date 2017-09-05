//
//  ArtUIStyleManager.swift
//  ChangeTheme_Swift
//
//  Created by weijingyun on 2017/9/4.
//  Copyright © 2017年 weijingyun. All rights reserved.
//

import UIKit

fileprivate let kArtUIStyleTypeSavekey = "ArtUIStyleManager_styleType"
fileprivate let kArtUIStylePathSavekey = "ArtUIStyleManager_stylePath"

fileprivate let kArtUIStyleClearKey = "kArtUIStyleClearKey";
fileprivate let kArtUIStyleBlockKey = "kArtUIStyleBlockKey";

enum EArtUIStyleType : NSInteger {
    case Default    // 应用默认的 stylePath = nil
    case Bundle     // Bundle   stylePath = BundlePath
    case Path       // 下载的文件夹 stylePath = 文件夹路径
}

//MARK: 使用闭包做弱引用解包
typealias ArtWeakReference = ()->(AnyObject?)

func artMakeWeakReference(object : AnyObject) -> ArtWeakReference {
    return { [weak object] in
        return object
    };
}

func weakReferenceNonretainedObjectValue(ref : ArtWeakReference?) -> AnyObject? {
    return ref != nil ? ref!() : nil
}

//MARK: ArtUIStyleManager
class ArtUIStyleManager: NSObject {
    
    private var styles = [String : [String : Dictionary<String, Any>]]()
    private var blocks = [[String : AnyObject]]()
    private var styleType = EArtUIStyleType.Default
    private var stylePath : String?
    
    
    static let share = ArtUIStyleManager()
    override init() {
        super.init()
        readConfig()
        do {
            switch styleType {
                
            case .Default:
                reloadNewStyle(bundle: Bundle.main)
                break
                
            case .Bundle:
                let bundle = try Bundle.init(path: try stylePath.unwrap()).unwrap()
                reloadNewStyle(bundle: bundle)
                break
            case .Path:
                reloadNewStyle(path: try stylePath.unwrap())
                break
            }

        } catch {
            reloadNewStyle(bundle: nil)
            print(error)
        }
        
    }
    
    class func artStyle(module : String, styleKey : String) -> ArtUIStyle {
        do {
            let exStyleDic = try share.styles[module].unwrap(tip:"模块不存在")["Style"].unwrap(tip:"Style不存在")
            let styleDic = try exStyleDic[styleKey].unwrap(tip:"不存在该key") as! [String : AnyObject]
            return ArtUIStyle.init(styleDic: styleDic)
            
        } catch {
            print(error)
            assert(false, error.localizedDescription)
        }
    }

    class func artImage(module : String, imageString : String) -> ArtUIStyle {
        do {
            let imageDic = try share.styles[module].unwrap(tip:"模块不存在")["Image"].unwrap(tip:"Image不存在") as [String : AnyObject]
            return ArtUIStyle.init(imageDic: imageDic, imageString: imageString)
            
        } catch {
            print(error)
            assert(false, error.localizedDescription)
        }
    }
    
    func reloadNewStyle(bundleName : String) {
        
        do {
            let bundlePath = try Bundle.main.path(forResource: bundleName, ofType: "bundle").unwrap()
            let bundle = try Bundle.init(path: bundlePath).unwrap()
            reloadNewStyle(bundle: bundle)
        } catch  {
            reloadNewStyle(bundle: nil)
            print(error)
        }
    }
    
    func reloadNewStyle(bundle : Bundle?) {
        if bundle == nil || bundle == Bundle.main {
            styleType = EArtUIStyleType.Default
            stylePath = nil
        }else {
            styleType = EArtUIStyleType.Bundle
            stylePath = bundle!.bundlePath
        }
        saveConfig()
        
        reloadStyle { (styleName) in
            
            var filePath : String
            do {
                filePath = try bundle.unwrap().path(forResource: styleName, ofType: nil).unwrap()
            } catch {
                filePath = Bundle.main.path(forResource: styleName, ofType: nil)!
                print(error)
            }
            addEntriesFromPath(path: filePath)
        }
        
    }
    
    func reloadNewStyle(path : String) {
        styleType = EArtUIStyleType.Path
        stylePath = path
        saveConfig()
        reloadStyle { (styleName) in
            var filePath = path.appending("/"+styleName)
            if !FileManager.default.fileExists(atPath: filePath) {
                filePath = Bundle.main.path(forResource: styleName, ofType: nil)!
            }
            addEntriesFromPath(path: filePath)
        }
    }
    
    func saveStyle(strongSelf : AnyObject, block : @escaping ()->()) {
        let dic = [kArtUIStyleClearKey:artMakeWeakReference(object: strongSelf),kArtUIStyleBlockKey:block] as [String : AnyObject]
        blocks.append(dic)
        block()
    }

    // 对已有界面刷一遍
    func reload() {
        let newBlocks = blocks
        blocks.removeAll()
        for (_,value) in newBlocks.enumerated() {
            let weakRef = value[kArtUIStyleClearKey] as!ArtWeakReference
            let key = weakReferenceNonretainedObjectValue(ref: weakRef)
            let block = value[kArtUIStyleBlockKey] as!()->()
            if key != nil {
                saveStyle(strongSelf: key!, block: block)
            }
        }
    }
    
    //MARK: private 私有方法
    private func readConfig() {
        let defaults = UserDefaults.standard
        styleType = EArtUIStyleType(rawValue: defaults.integer(forKey: kArtUIStyleTypeSavekey))!
        do {
            let path = try defaults.string(forKey: kArtUIStylePathSavekey).unwrap()
            let range = try path.range(of: "Documents").unwrap()
            let relativePath = path .substring(from: range.upperBound)
            let documentDirectory = try NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true).first.unwrap()
            stylePath = documentDirectory.appending(relativePath)
        } catch {
            stylePath = nil
            print(error)
        }
    }
    
    private func saveConfig() {
        let defaults = UserDefaults.standard
        defaults.set(styleType.rawValue, forKey: kArtUIStyleTypeSavekey)
        defaults.set(stylePath, forKey: kArtUIStylePathSavekey)
        defaults.synchronize()
    }
    
    private func addEntriesFromPath(path : String) {
        do {
            let dic = try NSDictionary.init(contentsOfFile: path).unwrap() as! [String: [String : Dictionary<String, Any>]]
            for (_, Value) in dic.enumerated() {
                styles.updateValue(Value.value, forKey: Value.key)
            }
        } catch  {
            print(error)
        }
    }
    
    private func reloadStyle(aBlock: (_ : String)->Void) {
        styles.removeAll()
        buildAppStyle(aBlock: aBlock)
        reload()
    }
    
    private func buildAppStyle(aBlock: (_ : String)->Void) {
        
        do {
            let funs = try art_getMethod(byListPrefix: "getStyleName_").unwrap(tip:"没有重写 getStyleName_")
            for (_, value) in funs.enumerated() {
                let selReturn = self.perform(NSSelectorFromString(value))
                let styleName = try selReturn.unwrap(tip:"返回值为nil").takeUnretainedValue() as!String
                aBlock(styleName)
            }
        } catch {
            print(error)
        }
        
    }
}
