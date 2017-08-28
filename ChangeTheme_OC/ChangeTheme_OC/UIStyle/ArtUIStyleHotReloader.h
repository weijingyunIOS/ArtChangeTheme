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

// HotReloader 用于动态测试使用
- (void)hotReloaderBundlePath:(NSString *)path;

- (void)startHotReloader;
- (void)endHotReloader;

@end
