//
//  ArtUIStyleManager+UIStyleModule1.m
//  ChangeTheme_OC
//
//  Created by weijingyun on 2017/8/22.
//  Copyright © 2017年 weijingyun. All rights reserved.
//

#import "ArtUIStyleManager+UIStyleModule2.h"
#import "ArtUIStyle.h"

@implementation ArtUIStyleManager (UIStyleModule2)

- (NSString *)getStyleName_Module2 {
    return @"Module2Style.plist";
}

@end


@implementation UIColor (UIStyleModule2)

+ (void)artModule2ForKey:(NSString *)aColorKey strongSelf:(id)strongSelf block:(void(^)(UIColor *color, id weakSelf))aBlock {
    [self artModule:@"Module2" colorForKey:aColorKey strongSelf:strongSelf block:aBlock];
}

@end

@implementation UIFont (UIStyleModule2)

+ (void)artModule2ForKey:(NSString *)aFontKey block:(id(^)(UIFont *))aBlock {
    [self artModule:@"Module2" fontForKey:aFontKey block:aBlock];
}

@end
