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

+ (void)artModule1ForKey:(NSString *)aColorKey block:(void(^)(UIColor *))aBlock;

@end


@interface UIFont (UIStyleModule1)

+ (void)artModule1ForKey:(NSString *)aFontKey block:(void(^)(UIFont *))aBlock;

@end
