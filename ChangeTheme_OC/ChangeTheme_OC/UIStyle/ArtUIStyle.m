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

@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat centerXOffset;
@property (nonatomic, assign) CGFloat centerYOffset;


@property (nonatomic, strong) UIColor *styleColor;
@property (nonatomic, strong) UIFont *styleFont;
@property (nonatomic, strong) UIImage *styleImage;

@property (nonatomic, strong) NSDictionary* style;

@end

@implementation ArtUIStyle

- (id)initWithStyle:(NSDictionary *)aStyle
{
    if (self = [super init]) {
        _style = aStyle;
        [self setValuesForKeysWithDictionary:aStyle];
    }
    return self;
}

- (instancetype)initWithStyle:(NSDictionary *)aStyle imageString:(NSString *)aImageString{
    if (self = [super init]) {
        _style = aStyle;
        self.styleImage = [self imageString:aImageString];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

}


- (UIFont *)styleFont
{
    if (!_styleFont) {
        NSNumber *num = [self.style objectForKey:kArtUIStyleFontKey];
        NSAssert(num != nil, @"配置的字体大小不存在请检查");
        _styleFont = [UIFont systemFontOfSize:[num doubleValue]];
    }
    return _styleFont;
}

- (UIColor *)styleColor
{
    if (!_styleColor) {
        NSString *colorStr = [self.style objectForKey:kArtUIStyleColorKey];
        colorStr = [colorStr stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSAssert(colorStr.length > 0, @"配置的颜色值不存在请检查");
        NSArray<NSString *> *colorArray = [colorStr componentsSeparatedByString:@","];
        NSString *hexStr = colorArray.firstObject;
        CGFloat alpha = 1.0;
        if (colorArray.count == 2) {
            alpha = [colorArray.lastObject doubleValue];
        }
        _styleColor = [UIColor art_colorWithHexString:hexStr alpha:alpha];
        
    }
    return [_styleColor copy];
}

- (UIImage *)styleImage {
    return [_styleImage copy];
}

- (UIImage *)imageString:(NSString *)aImageString {
    
    ArtUIStyleManager *manager = [ArtUIStyleManager shared];
    NSString *toPath = self.style[@"toPath"];
    UIImage *image = nil;
    switch (manager.styleType) {
        case EArtUIStyleTypeDefault:
        {
             image = [UIImage imageNamed:aImageString];
        }
            break;
            
        case EArtUIStyleTypeBundle:
        {
            image =
            [self findImageForImageString:aImageString block:^NSString *(NSString *path) {
                return [[NSBundle bundleWithPath:manager.stylePath] pathForResource:path ofType:@"png" inDirectory:toPath];
            }];
            
        }
            break;
            
        case EArtUIStyleTypeStylePath:
        {
            image =
            [self findImageForImageString:aImageString block:^NSString *(NSString *path) {
                NSString *filePath = [[manager.stylePath stringByAppendingPathComponent:toPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",path]];
                return filePath;
            }];
        }
            break;
            
        default:
            break;
    }
    return image;
}

- (UIImage *)findImageForImageString:(NSString *)aImageString block:(NSString *(^)(NSString * path))aBlock {
    NSMutableArray *arrayM = [NSMutableArray new];
    for (int i = 1; i <= 3; i ++) {
        [arrayM addObject:@(i)];
    }
    NSInteger scale = (NSInteger)[UIScreen mainScreen].scale;
    [arrayM removeObject:@(scale)];
    [arrayM insertObject:@(scale) atIndex:0];
    
    __block UIImage *image = nil;
    [arrayM enumerateObjectsUsingBlock:^(NSNumber *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger scale = obj.integerValue;
        NSString *imageStr = aImageString;
        if (scale != 1) {
            imageStr = [NSString stringWithFormat:@"%@@%tux",aImageString,scale];
        }
        NSString *imagePath = aBlock(imageStr);
        image = [UIImage imageWithContentsOfFile:imagePath];
        if (image) {
            *stop = YES;
        }
    }];
    if (image == nil) {
        NSAssert(NO, @"未在资源中找到可用的图");
        image = [UIImage imageNamed:aImageString];
    }
    return image;
}

@end


@implementation ArtUIStyle (ArtUIStyleApp)

+ (instancetype)artModule:(NSString *)aModule styleForKey:(NSString *)aStyleKey {
    return [[ArtUIStyleManager shared] artStyleModule:aModule styleKey:aStyleKey];
}

+ (void)artModule:(NSString *)aModule styleForKey:(NSString *)aStyleKey strongSelf:(id)strongSelf block:(void(^)(ArtUIStyle *style, id weakSelf))aBlock {
    if (strongSelf) {
        [[ArtUIStyleManager shared] saveStrongSelf:strongSelf block:^(id weakSelf) {
            ArtUIStyle *style = [self artModule:aModule styleForKey:aStyleKey];
            aBlock(style,weakSelf);
        }];
    }
}

@end

@implementation UIColor (ArtUIStyleApp)

+ (UIColor *)artModule:(NSString *)aModule colorForKey:(NSString *)aColorKey {
    return [ArtUIStyle artModule:aModule styleForKey:aColorKey].styleColor;
}

+ (void)artModule:(NSString *)aModule colorForKey:(NSString *)aColorKey strongSelf:(id)strongSelf block:(void(^)(UIColor *color, id weakSelf))aBlock {
    if (strongSelf) {
        [[ArtUIStyleManager shared] saveStrongSelf:strongSelf block:^(id weakSelf) {
            UIColor *color = [self artModule:aModule colorForKey:aColorKey];
            aBlock(color,weakSelf);
        }];
    }
}

@end

@implementation UIFont (ArtUIStyleApp)

+ (UIFont *)artModule:(NSString *)aModule fontForKey:(NSString *)aFontKey {
    return [ArtUIStyle artModule:aModule styleForKey:aFontKey].styleFont;
}

+ (void)artModule:(NSString *)aModule fontForKey:(NSString *)aFontKey strongSelf:(id)strongSelf block:(void(^)(UIFont *font, id weakSelf))aBlock {

    if (strongSelf) {
        [[ArtUIStyleManager shared] saveStrongSelf:strongSelf block:^(id weakSelf) {
            UIFont *font = [self artModule:aModule fontForKey:aFontKey];
            aBlock(font,weakSelf);
        }];
    }
}

@end


@implementation UIImage (ArtUIStyleApp)

+ (UIImage *)artModule:(NSString *)aModule imageString:(NSString *)aImageString {
    return [[ArtUIStyleManager shared] artImageModule:aModule imageString:aImageString].styleImage;
}

+ (void)artModule:(NSString *)aModule imageString:(NSString *)aImageString strongSelf:(id)strongSelf block:(void(^)(UIImage *image, id weakSelf))aBlock {
    
    if (strongSelf) {
        [[ArtUIStyleManager shared] saveStrongSelf:strongSelf block:^(id weakSelf) {
            UIImage *image = [self artModule:aModule imageString:aImageString];
            aBlock(image,weakSelf);
        }];
    }
}

@end
