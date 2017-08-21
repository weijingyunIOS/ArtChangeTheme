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

+ (UIColor *)artModule1ForKey:(NSString *)aColorKey;

@end


@interface UIFont (UIStyleModule1)

+ (UIFont *)artModule1ForKey:(NSString *)aFontKey;

@end
