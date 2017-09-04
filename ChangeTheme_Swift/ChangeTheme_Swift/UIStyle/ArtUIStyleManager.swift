//
//  ArtUIStyleManager.swift
//  ChangeTheme_Swift
//
//  Created by weijingyun on 2017/9/4.
//  Copyright © 2017年 weijingyun. All rights reserved.
//

import UIKit

fileprivate let kUIStyleTypeSavekey = "ArtUIStyleManager_styleType"
fileprivate let kUIStylePathSavekey = "ArtUIStyleManager_stylePath"

enum EArtUIStyleType : NSInteger {
    case Default    // 应用默认的 stylePath = nil
    case Bundle     // Bundle   stylePath = BundlePath
    case Path       // 下载的文件夹 stylePath = 文件夹路径
}

class ArtUIStyleManager: NSObject {
    
    private var styles = [String: [String : Dictionary<String, Any>]]()
    private let blocks = NSMutableArray()
    private var styleType = EArtUIStyleType.Default
    private var stylePath : String?
    
    
    static let share = ArtUIStyleManager()
    override init() {
        super.init()
        readConfig()
        print("styleType:",styleType,"\n","stylePath:",stylePath ?? "不存在")
        buildAppStyle(aBlock: { (styleName) in
            print(styleName)
        })
        
        reloadNewStyle(path: "aaa")
        switch styleType {
            case .Default:
                
            break
            case .Bundle:
               
            break
            case .Path:
            break
        }
    }
    
    func reload() {
        print("待实现")
    }
    
    private func readConfig() {
        let defaults = UserDefaults.standard
        styleType = EArtUIStyleType(rawValue: defaults.integer(forKey: kUIStyleTypeSavekey))!
        do {
            let path = try defaults.string(forKey: kUIStylePathSavekey).unwrap()
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
        defaults.set(styleType.rawValue, forKey: kUIStyleTypeSavekey)
        defaults.set(stylePath, forKey: kUIStylePathSavekey)
        defaults.synchronize()
    }
    
    func addEntriesFromPath(path : String) {
        do {
            let dic = try NSDictionary.init(contentsOfFile: path).unwrap() as! [String: [String : Dictionary<String, Any>]]
            for (_, Value) in dic.enumerated() {
                styles.updateValue(Value.value, forKey: Value.key)
            }
        } catch  {
            print(error)
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
    
    func reloadStyle(aBlock: (_ : String)->Void) {
        styles.removeAll()
        buildAppStyle(aBlock: aBlock)
        reload()
    }
    
    func buildAppStyle(aBlock: (_ : String)->Void) {
        
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
