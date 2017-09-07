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
    
    func hotReloaderBundlePath(path : String) {
        Simulator {
            let watchDog = SGDirWatchdog.init(path: path) {
                let bundle = Bundle.init(path: path)
                ArtUIStyleManager.share.reloadNewStyle(bundle: bundle)
            }
            watchDogs.append(watchDog!)
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
    
    private func watchStyleFile(watch : Bool) {
        
        watchDogs.forEach { (dog) in
            watch ? dog.start() : dog.stop()
        }
    }
}
