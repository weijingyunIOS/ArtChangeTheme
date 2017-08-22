//
//  ArtUIStyleManager.h
//  ChangeTheme_OC
//
//  Created by weijingyun on 2017/8/22.
//  Copyright © 2017年 weijingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  样式配置
 *  将UI相关抽离出来，统一管理和配置，支持从文件中导入和运行时调整
 */

extern NSString* const kArtUIStyleFontKey;
extern NSString* const kArtUIStyleColorKey;

@interface ArtUIStyleManager : NSObject

@property (nonatomic, strong,readonly) NSMutableDictionary* styles;
- (void)saveKey:(id)aKey block:(void(^)())aBlock;


+ (instancetype)shared;
- (void)addEntriesFromPath:(NSString *)aPath;
- (void)reloadStyle:(void(^)(ArtUIStyleManager *manager))aBlock;

@end
