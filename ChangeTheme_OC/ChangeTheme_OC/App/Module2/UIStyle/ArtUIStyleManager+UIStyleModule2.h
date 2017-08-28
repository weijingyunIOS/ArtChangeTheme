//
//  ArtUIStyleManager+UIStyleModule1.h
//  ChangeTheme_OC
//
//  Created by weijingyun on 2017/8/22.
//  Copyright © 2017年 weijingyun. All rights reserved.
//

#import "ArtUIStyleManager.h"

@interface ArtUIStyleManager (UIStyleModule2)

- (NSString *)getStyleName_Module2;

@end


#define kUIStyleModule2DrawColor  @"DrawColor" // 备注

@interface UIColor (UIStyleModule2)

+ (UIColor *)artModule2ForKey:(NSString *)aColorKey;
+ (void)artModule2ForKey:(NSString *)aColorKey strongSelf:(id)strongSelf block:(void(^)(UIColor *color, id weakSelf))aBlock;

@end


@interface UIFont (UIStyleModule2)

+ (UIFont *)artModule2ForKey:(NSString *)aFontKey;
+ (void)artModule2ForKey:(NSString *)aFontKey strongSelf:(id)strongSelf block:(void(^)(UIFont *color, id weakSelf))aBlock;

@end
