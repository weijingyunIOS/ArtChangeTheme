//
//  ArtUIStyle.h
//  ChangeTheme_OC
//
//  Created by weijingyun on 2017/8/21.
//  Copyright © 2017年 weijingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ArtUIStyle : NSObject

+ (ArtUIStyle *)styleForKey:(NSString *)aKey;
// 外部定制自己的Style
+ (void)addStyle:(NSDictionary *)aStyle key:(NSString *)aKey;

- (UIFont *)font;
- (UIColor *)color;
- (ArtUIStyle *)styleForKey:(NSString *)aKey;

@end


@interface UIColor (ArtUIStyleApp)

+ (void)artModule:(NSString *)aModule colorForKey:(NSString *)aColorKey strongSelf:(id)strongSelf block:(void(^)(UIColor *color, id weakSelf))aBlock;

// 该方法不建议使用
+ (void)artModule:(NSString *)aModule colorForKey:(NSString *)aColorKey block:(id(^)(UIColor *))aBlock;

@end

@interface UIFont (ArtUIStyleApp)

+ (void)artModule:(NSString *)aModule fontForKey:(NSString *)aFontKey strongSelf:(id)strongSelf block:(void(^)(UIFont *font, id weakSelf))aBlock;

+ (void)artModule:(NSString *)aModule fontForKey:(NSString *)aFontKey block:(id(^)(UIFont *))aBlock;

@end
