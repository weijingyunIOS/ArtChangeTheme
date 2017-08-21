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

+ (void)artModule1ForKey:(NSString *)aColorKey block:(void(^)(UIColor *))aBlock{
    [self artModule:@"Module1" colorForKey:aColorKey block:aBlock];
}

@end

@implementation UIFont (UIStyleCourseware)

+ (void)artModule1ForKey:(NSString *)aFontKey block:(void(^)(UIFont *))aBlock {
    [self artModule:@"Module1" fontForKey:aFontKey block:aBlock];
}

@end
