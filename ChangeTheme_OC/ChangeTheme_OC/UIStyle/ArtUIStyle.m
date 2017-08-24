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
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIImage *image;

@end

@implementation ArtUIStyle

+ (ArtUIStyle *)styleForKey:(NSString *)aKey
{
    return [[ArtUIStyleManager shared] styleForKey:aKey];
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
    if (!_color) {
        NSString *colorStr = [self.style objectForKey:kArtUIStyleColorKey];
        colorStr = [colorStr stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSAssert(colorStr.length > 0, @"配置的颜色值不存在请检查");
        NSArray<NSString *> *colorArray = [colorStr componentsSeparatedByString:@","];
        NSString *hexStr = colorArray.firstObject;
        CGFloat alpha = 1.0;
        if (colorArray.count == 2) {
            alpha = [colorArray.lastObject doubleValue];
        }
        _color = [UIColor art_colorWithHexString:hexStr alpha:alpha];
        
    }else {
        NSLog(@"aaaaaa");
    }
    return [_color copy];
}

- (ArtLayoutInfo *)layoutInfo {
    
    NSAssert(self.style.count > 0, @"不存在该配置请检查");
    ArtLayoutInfo *info = [ArtLayoutInfo new];
    [info setValuesForKeysWithDictionary:self.style];
    return info;
}

- (ArtUIStyle *)styleForKey:(NSString *)aKey
{
    return [[ArtUIStyle alloc] initWithStyle:self.style[@"Style"][aKey]];
}

- (ArtUIStyle *)imageForKey:(NSString *)aKey
{
    return [[ArtUIStyle alloc] initWithStyle:self.style[@"Image"][aKey]];
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

+ (void)artModule:(NSString *)aModule fontForKey:(NSString *)aFontKey strongSelf:(id)strongSelf block:(void(^)(UIFont *font, id weakSelf))aBlock {
   
    UIFont *font = [[[ArtUIStyle styleForKey:aModule] styleForKey:aFontKey] font];
    aBlock(font,strongSelf);
    if (strongSelf) {
        __weak id weakSelf = strongSelf;
        [[ArtUIStyleManager shared] saveKey:strongSelf block:^{
            __strong id strongSelf = weakSelf;
            [self artModule:aModule fontForKey:aFontKey strongSelf:strongSelf block:aBlock];
        }];
    }
}

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


@implementation ArtLayoutInfo (ArtUIStyleApp)

+ (void)artModule:(NSString *)aModule layoutForKey:(NSString *)aLayoutKey strongSelf:(id)strongSelf block:(void(^)(ArtLayoutInfo *layoutInfo, id weakSelf))aBlock {
    
    ArtLayoutInfo *layoutInfo = [[[ArtUIStyle styleForKey:aModule] styleForKey:aLayoutKey] layoutInfo];
    aBlock(layoutInfo,strongSelf);
    if (strongSelf) {
        __weak id weakSelf = strongSelf;
        [[ArtUIStyleManager shared] saveKey:strongSelf block:^{
            __strong id strongSelf = weakSelf;
            [self artModule:aModule layoutForKey:aLayoutKey strongSelf:strongSelf block:aBlock];
        }];
    }
}

// 该方法不建议使用
+ (void)artModule:(NSString *)aModule layoutForKey:(NSString *)aLayoutKey block:(id(^)(ArtLayoutInfo *layoutInfo))aBlock {
    
    ArtLayoutInfo *layoutInfo = [[[ArtUIStyle styleForKey:aModule] styleForKey:aLayoutKey] layoutInfo];
    id key = aBlock(layoutInfo);
    if (key != nil) {
        [[ArtUIStyleManager shared] saveKey:key block:^{
            [self artModule:aModule layoutForKey:aLayoutKey block:aBlock];
        }];
    }
}

@end


@implementation UIImage (ArtUIStyleApp)

+ (void)artModule:(NSString *)aModule imageString:(NSString *)aImageString strongSelf:(id)strongSelf block:(void(^)(UIImage *image, id weakSelf))aBlock {
    
}

// 该方法不建议使用
+ (void)artModule:(NSString *)aModule imageString:(NSString *)aImageString block:(id(^)(UIImage *image))aBlock {

}

@end
