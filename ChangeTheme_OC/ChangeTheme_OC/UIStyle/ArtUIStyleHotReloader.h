//
//  ArtUIStyleHotReloader.h
//  ChangeTheme_OC
//
//  Created by weijingyun on 2017/8/28.
//  Copyright © 2017年 weijingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArtUIStyleHotReloader : NSObject

+ (instancetype)shared;
- (void)startHotReloader;
- (void)endHotReloader;

#pragma mark - 下面是互斥的请只使用一种
// HotReloader 用于动态测试使用 styleBundle1.bundle
- (void)hotReloaderBundlePath:(NSString *)path;

// 传入工程路径，依赖各个模块分类 实现 - (NSString *)getHotReloaderStylePath_模块名
- (void)hotMainReloaderByProjectPath:(NSString *)path;

@end
