//
//  ArtUIStyle.m
//  ChangeTheme_OC
//
//  Created by weijingyun on 2017/8/21.
//  Copyright © 2017年 weijingyun. All rights reserved.
//

#import "ArtUIStyle.h"
#import "ArtUIStyleManager.h"
#import "UIColor+HexColor.h"


#pragma mark - ArtUIStyle

@interface ArtUIStyle ()

@property (nonatomic, strong) NSDictionary* style;

@end

@implementation ArtUIStyle

+ (ArtUIStyle *)styleForKey:(NSString *)aKey
{
    ArtUIStyle* style = [[ArtUIStyle alloc] init];
    
    style.style = [[ArtUIStyleManager shared].styles objectForKey:aKey];
    
    return style;
}

+ (void)addStyle:(NSDictionary *)aStyle key:(NSString *)aKey
{
    [[ArtUIStyleManager shared].styles setObject:aStyle forKey:aKey];
}

- (id)initWithStyle:(NSDictionary *)aStyle
{
    self = [super init];
    
    _style = aStyle;
    
    return self;
}

- (UIFont *)font
{
    NSNumber *num = [self.style objectForKey:kArtUIStyleFontKey];
    NSAssert(num != nil, @"配置的字体大小不存在请检查");
    return [UIFont systemFontOfSize:[num doubleValue]];
}

- (UIColor *)color
{
    NSString *colorStr = [self.style objectForKey:kArtUIStyleColorKey];
    colorStr = [colorStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSAssert(colorStr.length > 0, @"配置的颜色值不存在请检查");
    NSArray<NSString *> *colorArray = [colorStr componentsSeparatedByString:@","];
    NSString *hexStr = colorArray.firstObject;
    CGFloat alpha = 1.0;
    if (colorArray.count == 2) {
        alpha = [colorArray.lastObject doubleValue];
    }
    return [UIColor art_colorWithHexString:hexStr alpha:alpha];
}

- (ArtUIStyle *)styleForKey:(NSString *)aKey
{
    return [[ArtUIStyle alloc] initWithStyle:[self.style objectForKey:aKey]];
}

@end

@implementation UIColor (ArtUIStyleApp)

+ (void)artModule:(NSString *)aModule colorForKey:(NSString *)aColorKey strongSelf:(id)strongSelf block:(void(^)(UIColor *color, id weakSelf))aBlock {
    UIColor *color = [[[ArtUIStyle styleForKey:aModule] styleForKey:aColorKey] color];
    aBlock(color,strongSelf);
    if (strongSelf) {
        __weak id weakSelf = strongSelf;
        [[ArtUIStyleManager shared] saveKey:strongSelf block:^{
            __strong id strongSelf = weakSelf;
            [self artModule:aModule colorForKey:aColorKey strongSelf:strongSelf block:aBlock];
        }];
    }
}

+ (void)artModule:(NSString *)aModule colorForKey:(NSString *)aColorKey block:(id(^)(UIColor *))aBlock {
    UIColor *color = [[[ArtUIStyle styleForKey:aModule] styleForKey:aColorKey] color];
    id key = aBlock(color);
    if (key != nil) {
        [[ArtUIStyleManager shared] saveKey:key block:^{
            [self artModule:aModule colorForKey:aColorKey block:aBlock];
        }];
    }
}

@end

@implementation UIFont (ArtUIStyleApp)

+ (void)artModule:(NSString *)aModule fontForKey:(NSString *)aFontKey block:(id(^)(UIFont *))aBlock {
    UIFont *font = [[[ArtUIStyle styleForKey:aModule] styleForKey:aFontKey] font];
    id key = aBlock(font);
    if (key != nil) {
        [[ArtUIStyleManager shared] saveKey:key block:^{
            [self artModule:aModule fontForKey:aFontKey block:aBlock];
        }];
    }
}

@end
