//
//  ArtUIStyleManager.swift
//  ChangeTheme_Swift
//
//  Created by weijingyun on 2017/9/4.
//  Copyright © 2017年 weijingyun. All rights reserved.
//

import UIKit
//import SwiftString

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
        
        let time: TimeInterval = 1.0
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
            
//            NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
//            path = [documentDirectory stringByAppendingPathComponent:path];
            let documentDirectory = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true).first
            
            
            self.stylePath = documentDirectory?.appending("/aaaaa")
            self.styleType = EArtUIStyleType.Bundle
            self.saveConfig()
        }
        readConfig()
        switch styleType {
            case .Default:
                print(styleType)
            break
            case .Bundle:
               print(styleType)
            break
            case .StylePath:
                print(styleType)
            break
        }
    }
    
    private func readConfig() {
        let defaults = UserDefaults.standard
        styleType = EArtUIStyleType(rawValue: defaults.integer(forKey: "ArtUIStyleManager_styleType"))!
        do {
            let path = try defaults.string(forKey: "ArtUIStyleManager_stylePath").unwrap()
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
        defaults.set(styleType.rawValue, forKey: "ArtUIStyleManager_styleType")
        defaults.set(stylePath, forKey: "ArtUIStyleManager_stylePath")
        defaults.synchronize()
    }
    
}
