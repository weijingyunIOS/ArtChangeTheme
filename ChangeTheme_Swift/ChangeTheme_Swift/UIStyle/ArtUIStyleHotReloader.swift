//
//  ArtUIStyleHotReloader.swift
//  ChangeTheme_Swift
//
//  Created by weijingyun on 2017/9/7.
//  Copyright © 2017年 weijingyun. All rights reserved.
//

import UIKit

func Simulator(block : ()->()) {
    #if arch(i386) || arch(x86_64)
        block()
    #endif
}

class ArtUIStyleHotReloader: NSObject {
    
    static let shared = ArtUIStyleHotReloader()
    var isHotReload = false
    var watchDogs = [SGDirWatchdog]()
    
    func hotReloader(bundlePath : String) {
        Simulator {
            let watchDog = SGDirWatchdog.init(path: bundlePath) {
                let bundle = Bundle.init(path: bundlePath)
                ArtUIStyleManager.share.reloadNewStyle(bundle: bundle)
            }
            watchDogs.append(watchDog!)
        }
    }
    
    func hotReloader(mainProjectPath : String) {
        do {
            let funs = try ArtUIStyleManager.share.art_getMethod(byListPrefix: "getHotReloaderStylePath_").unwrap(tip:"没有重写 getHotReloaderStylePath_")
            try funs.forEach({ (selString) in
                let selReturn = ArtUIStyleManager.share.perform(NSSelectorFromString(selString))
                let stylePath = try selReturn.unwrap(tip:"返回值为nil").takeUnretainedValue() as!String
                watch(filepath: mainProjectPath + "/" + stylePath)
            })
        } catch {
            print(error)
        }
    }
    
    func startHotReloader() {
        Simulator {
            watchStyleFile(watch: true)
        }
    }
    
    func endHotReloader() {
        Simulator {
            watchStyleFile(watch: false)
        }
    }
    
    //mark:私有方法
    private func watch(filepath : String) {
        Simulator {
            let watchPaht = NSString(string:filepath).deletingLastPathComponent
            let watchDog = SGDirWatchdog.init(path: watchPaht) {
                ArtUIStyleManager.share.addEntriesFromPath(path: filepath)
                ArtUIStyleManager.share.reload()
            }
            watchDogs.append(watchDog!)
        }
    }
    
    private func watchStyleFile(watch : Bool) {
        
        watchDogs.forEach { (dog) in
            watch ? dog.start() : dog.stop()
        }
    }
}
