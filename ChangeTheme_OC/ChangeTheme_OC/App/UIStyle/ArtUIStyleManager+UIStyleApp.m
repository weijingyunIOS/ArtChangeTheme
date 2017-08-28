//
//  ArtUIStyleManager+UIStyleApp.m
//  ChangeTheme_OC
//
//  Created by weijingyun on 2017/8/24.
//  Copyright © 2017年 weijingyun. All rights reserved.
//

#import "ArtUIStyleManager+UIStyleApp.h"

@implementation ArtUIStyleManager (UIStyleApp)

- (NSString *)getStyleName_App {
    return @"AppStyle.plist";
}

@end


@implementation UIColor (UIStyleApp)

+ (UIColor *)artAppForKey:(NSString *)aColorKey {
    return [self artModule:@"App_Main" colorForKey:aColorKey];
}

+ (void)artAppForKey:(NSString *)aColorKey strongSelf:(id)strongSelf block:(void(^)(UIColor *color, id weakSelf))aBlock {
    [self artModule:@"App_Main" colorForKey:aColorKey strongSelf:strongSelf block:aBlock];
}

@end

@implementation UIFont (UIStyleCourseware)

+ (UIFont *)artAppForKey:(NSString *)aFontKey {
    return [self artModule:@"App_Main" fontForKey:aFontKey];
}

+ (void)artAppForKey:(NSString *)aFontKey strongSelf:(id)strongSelf block:(void(^)(UIFont *font, id weakSelf))aBlock {
    [self artModule:@"App_Main" fontForKey:aFontKey strongSelf:strongSelf block:aBlock];
}

@end
