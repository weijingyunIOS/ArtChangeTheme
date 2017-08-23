//
//  ArtUIStyleManager+UIStyleModule4.m
//  ChangeTheme_OC
//
//  Created by weijingyun on 2017/8/22.
//  Copyright © 2017年 weijingyun. All rights reserved.
//

#import "ArtUIStyleManager+UIStyleModule4.h"
#import "ArtUIStyle.h"

@implementation ArtUIStyleManager (UIStyleModule4)

- (NSString *)getStyleName_Module4 {
    return @"Module4Style.plist";
}

@end


@implementation UIColor (UIStyleModule4)

+ (void)artModule4ForKey:(NSString *)aColorKey strongSelf:(id)strongSelf block:(void(^)(UIColor *color, id weakSelf))aBlock {
    [self artModule:@"Module4" colorForKey:aColorKey strongSelf:strongSelf block:aBlock];
}

@end

@implementation UIFont (UIStyleCourseware)

+ (void)artModule4ForKey:(NSString *)aFontKey block:(id(^)(UIFont *))aBlock {
    [self artModule:@"Module4" fontForKey:aFontKey block:aBlock];
}

@end
