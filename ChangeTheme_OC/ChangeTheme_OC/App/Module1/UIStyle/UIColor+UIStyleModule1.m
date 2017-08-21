//
//  UIColor+UIStyleModule1.m
//  ChangeTheme_OC
//
//  Created by weijingyun on 2017/8/21.
//  Copyright © 2017年 weijingyun. All rights reserved.
//

#import "UIColor+UIStyleModule1.h"
#import "ArtUIStyle.h"

@implementation UIColor (UIStyleModule1)

+ (void)artModule1ForKey:(NSString *)aColorKey strongSelf:(id)strongSelf block:(void(^)(UIColor *color, id weakSelf))aBlock {
    [self artModule:@"Module1" colorForKey:aColorKey strongSelf:strongSelf block:aBlock];
}

+ (void)artModule1ForKey:(NSString *)aColorKey block:(id(^)(UIColor *))aBlock{
    [self artModule:@"Module1" colorForKey:aColorKey block:aBlock];
}

@end

@implementation UIFont (UIStyleCourseware)

+ (void)artModule1ForKey:(NSString *)aFontKey block:(id(^)(UIFont *))aBlock {
    [self artModule:@"Module1" fontForKey:aFontKey block:aBlock];
}

@end
