//
//  ArtUIStyleManager+UIStyleModule1.m
//  ChangeTheme_OC
//
//  Created by weijingyun on 2017/8/22.
//  Copyright © 2017年 weijingyun. All rights reserved.
//

#import "ArtUIStyleManager+UIStyleModule1.h"
#import "ArtUIStyle.h"

@implementation ArtUIStyleManager (UIStyleModule1)

- (NSString *)getStyleName_Module1 {
    return @"Module1Style.plist";
}

- (NSString *)getHotReloaderStylePath_Module1 {
    return @"/App/Module1/UIStyle/Module1Style.plist";
}

@end


@implementation UIColor (UIStyleModule1)

+ (UIColor *)artModule1ForKey:(NSString *)aColorKey {
    return [self artModule:@"Module1" colorForKey:aColorKey];
}

+ (void)artModule1ForKey:(NSString *)aColorKey strongSelf:(id)strongSelf block:(void(^)(UIColor *color, id weakSelf))aBlock {
    [self artModule:@"Module1" colorForKey:aColorKey strongSelf:strongSelf block:aBlock];
}

@end

@implementation UIFont (UIStyleModule1)

+ (UIFont *)artModule1ForKey:(NSString *)aFontKey {
    return [self artModule:@"Module1" fontForKey:aFontKey];
}

+ (void)artModule1ForKey:(NSString *)aFontKey strongSelf:(id)strongSelf block:(void(^)(UIFont *font, id weakSelf))aBlock {
    [self artModule:@"Module1" fontForKey:aFontKey strongSelf:strongSelf block:aBlock];
}

@end


@implementation UIImage (UIStyleModule1)

+ (UIImage *)artImageString:(NSString *)aImageString {
    return [self artModule:@"Module1" imageString:aImageString];
}

+ (void)artImageString:(NSString *)aImageString strongSelf:(id)strongSelf block:(void(^)(UIImage *image, id weakSelf))aBlock {
    [self artModule:@"Module1" imageString:aImageString strongSelf:strongSelf block:aBlock];
}

@end
