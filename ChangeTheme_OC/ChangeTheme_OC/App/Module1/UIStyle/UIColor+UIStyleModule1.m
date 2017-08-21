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

+ (UIColor *)artModule1ForKey:(NSString *)aColorKey {
    return [self artModule:@"Module1" colorForKey:aColorKey];
}

@end

@implementation UIFont (UIStyleCourseware)

+ (UIFont *)artModule1ForKey:(NSString *)aFontKey {
    return [self artModule:@"Module1" fontForKey:aFontKey];
}

@end
