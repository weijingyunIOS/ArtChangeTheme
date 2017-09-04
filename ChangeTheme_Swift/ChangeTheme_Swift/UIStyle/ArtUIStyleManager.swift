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
    case StylePath  // 下载的文件夹 stylePath = 文件夹路径
}

class ArtUIStyleManager: NSObject {
    
    private let styles = NSMutableDictionary()
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
        switch styleType {
            case .Default:
                
            break
            case .Bundle:
               
            break
            case .StylePath:
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
            let documentDirectory = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true).first
            stylePath = documentDirectory?.appending(relativePath)
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
    
    
    private func reloadStyle(aBlock: (_ : String)->Void) {
        styles.removeAllObjects()
        buildAppStyle(aBlock: aBlock)
        reload()
    }
    
    func buildAppStyle(aBlock: (_ : String)->Void) {
        
        do {
            let funs = try art_getMethod(byListPrefix: "getStyleName_").unwrap()
            for (_, value) in funs.enumerated() {
                let selReturn = self.perform(NSSelectorFromString(value))
                let styleName = try selReturn.unwrap().takeUnretainedValue() as!String
                aBlock(styleName)
            }
        } catch {
            print("没有重写 getStyleName_")
        }
        
    }
}
