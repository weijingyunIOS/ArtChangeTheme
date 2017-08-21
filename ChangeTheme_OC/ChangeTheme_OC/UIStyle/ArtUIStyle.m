//
//  ArtUIStyle.m
//  ChangeTheme_OC
//
//  Created by weijingyun on 2017/8/21.
//  Copyright © 2017年 weijingyun. All rights reserved.
//

#import "ArtUIStyle.h"
#import "UIColor+HexColor.h"

NSString* const kArtUIStyleFontKey = @"font";
NSString* const kArtUIStyleColorKey = @"color";

#pragma mark - ArtUIStyleManager

@interface ArtUIStyleManager : NSObject

@property (nonatomic, strong) NSMutableDictionary* styles;

+ (instancetype)shared;

@end

@implementation ArtUIStyleManager

+ (instancetype)shared
{
    static dispatch_once_t onceToken;
    static id shared = nil;
    dispatch_once(&onceToken, ^{
        shared = [self new];
    });
    return shared;
}

- (id)init
{
    self = [super init];
    
    self.styles = [NSMutableDictionary dictionary];
    
    [self build];
    
    return self;
}

- (void)load:(NSString *)aPath
{
    [self.styles addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:aPath]];
}

- (void)build
{
    [self buildAppStyle];
}

// 全局样式
- (NSDictionary *)scrollTabStyle
{
    return @{kArtUIStyleFontKey:[UIFont systemFontOfSize:16]};
}

- (void)buildAppStyle
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Module1Style" ofType:@"plist"];
    [self load:path];
}

@end

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

+ (UIColor *)artModule:(NSString *)aModule colorForKey:(NSString *)aColorKey {
    return [[[ArtUIStyle styleForKey:aModule] styleForKey:aColorKey] color];
}

@end

@implementation UIFont (ArtUIStyleApp)

+ (UIFont *)artModule:(NSString *)aModule fontForKey:(NSString *)aFontKey {
    return [[[ArtUIStyle styleForKey:aModule] styleForKey:aFontKey] font];
}

@end
