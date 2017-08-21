//
//  ArtUIStyle.h
//  ChangeTheme_OC
//
//  Created by weijingyun on 2017/8/21.
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

+ (instancetype)shared;
- (void)saveCall;

@end

@interface ArtUIStyle : NSObject

+ (ArtUIStyle *)styleForKey:(NSString *)aKey;
// 外部定制自己的Style
+ (void)addStyle:(NSDictionary *)aStyle key:(NSString *)aKey;

- (UIFont *)font;
- (UIColor *)color;
- (ArtUIStyle *)styleForKey:(NSString *)aKey;

@end


@interface UIColor (ArtUIStyleApp)

+ (void)artModule:(NSString *)aModule colorForKey:(NSString *)aColorKey block:(void(^)(UIColor *))aBlock;

@end

@interface UIFont (ArtUIStyleApp)

+ (void)artModule:(NSString *)aModule fontForKey:(NSString *)aFontKey block:(void(^)(UIFont *))aBlock;

@end
