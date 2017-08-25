//
//  ArtUIStyleManager.h
//  ChangeTheme_OC
//
//  Created by weijingyun on 2017/8/22.
//  Copyright © 2017年 weijingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArtUIStyle.h"
#import "UIImage+ArtDraw.h"

/**
 *  样式配置
 *  将UI相关抽离出来，统一管理和配置，支持从文件中导入和运行时调整
 */

extern NSString* const kArtUIStyleFontKey;
extern NSString* const kArtUIStyleColorKey;


// 内部存储对 document 做了相对路径处理，下载的配置请放在document 下
typedef enum : NSUInteger {
    EArtUIStyleTypeDefault,   // 应用默认的 stylePath = nil
    EArtUIStyleTypeBundle,    // Bundle   stylePath = BundlePath
    EArtUIStyleTypeStylePath, // 下载的文件夹 stylePath = 文件夹路径
} EArtUIStyleType;

@interface ArtUIStyleManager : NSObject

// 以下两字段记录当前配置
@property (nonatomic, assign) EArtUIStyleType styleType;
@property (nonatomic, copy) NSString *stylePath;
@property (nonatomic, strong,readonly) NSMutableDictionary* styles;
- (void)saveKey:(id)aKey block:(void(^)())aBlock;
- (ArtUIStyle *)styleForKey:(NSString *)aKey;

#pragma mark - 外部使用
// 清理间隔 默认 60s 设置 < 1s 不清理
@property (nonatomic, assign) CGFloat clearInterval;

+ (instancetype)shared;
- (void)addEntriesFromPath:(NSString *)aPath;
- (void)reloadStylePath:(NSString *)aStylePath;
- (void)reloadStyleBundleName:(NSString *)aStyleBundleName;
- (void)reloadStyleBundle:(NSBundle *)aStyleBundle;

@end
