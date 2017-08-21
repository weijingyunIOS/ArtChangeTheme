//
//  UIColor+UIStyleModule1.h
//  ChangeTheme_OC
//
//  Created by weijingyun on 2017/8/21.
//  Copyright © 2017年 weijingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kUIStyleModule1MainLabel  @"MainLabel" // 备注

@interface UIColor (UIStyleModule1)

+ (void)artModule1ForKey:(NSString *)aColorKey strongSelf:(id)strongSelf block:(void(^)(UIColor *color, id weakSelf))aBlock;

+ (void)artModule1ForKey:(NSString *)aColorKey block:(id(^)(UIColor *))aBlock;

@end


@interface UIFont (UIStyleModule1)

+ (void)artModule1ForKey:(NSString *)aFontKey block:(id(^)(UIFont *))aBlock;

@end
