//
//  ArtUIStyleManager+UIStyleModule4.h
//  ChangeTheme_OC
//
//  Created by weijingyun on 2017/8/22.
//  Copyright © 2017年 weijingyun. All rights reserved.
//

#import "ArtUIStyleManager.h"

@interface ArtUIStyleManager (UIStyleModule4)

- (NSString *)getStyleName_Module4;

@end


#define kUIStyleModule4Test  @"Test" // 备注

@interface ArtUIStyle (UIStyleModule4)

+ (instancetype)artModule4ForKey:(NSString *)aStyleKey;
+ (void)artModule4ForKey:(NSString *)aStyleKey strongSelf:(id)strongSelf block:(void(^)(ArtUIStyle *style, id weakSelf))aBlock;

@end


@interface UIColor (UIStyleModule4)

+ (UIColor *)artModule4ForKey:(NSString *)aColorKey;
+ (void)artModule4ForKey:(NSString *)aColorKey strongSelf:(id)strongSelf block:(void(^)(UIColor *color, id weakSelf))aBlock;

@end


@interface UIFont (UIStyleModule4)

+ (UIFont *)artModule4ForKey:(NSString *)aFontKey;
+ (void)artModule4ForKey:(NSString *)aFontKey strongSelf:(id)strongSelf block:(void(^)(UIFont *font, id weakSelf))aBlock;

@end

