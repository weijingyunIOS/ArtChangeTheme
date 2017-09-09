//
//  ArtUIStyle.h
//  ChangeTheme_OC
//
//  Created by weijingyun on 2017/8/21.
//  Copyright © 2017年 weijingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArtUIStyle : NSObject

@property (nonatomic, assign, readonly) CGFloat top;
@property (nonatomic, assign, readonly) CGFloat left;
@property (nonatomic, assign, readonly) CGFloat bottom;
@property (nonatomic, assign, readonly) CGFloat right;
@property (nonatomic, assign, readonly) CGFloat width;
@property (nonatomic, assign, readonly) CGFloat height;
@property (nonatomic, assign, readonly) CGFloat centerXOffset;
@property (nonatomic, assign, readonly) CGFloat centerYOffset;

@property (nonatomic, strong, readonly) UIColor *styleColor;
@property (nonatomic, strong, readonly) UIFont *styleFont;
@property (nonatomic, strong, readonly) UIImage *styleImage;

- (instancetype)initWithStyle:(NSDictionary *)aStyle;
- (instancetype)initWithStyle:(NSDictionary *)aStyle imageString:(NSString *)aImageString;

@end

@interface ArtUIStyle (ArtUIStyleApp)

+ (instancetype)artModule:(NSString *)aModule styleForKey:(NSString *)aStyleKey;
+ (void)artModule:(NSString *)aModule styleForKey:(NSString *)aStyleKey strongSelf:(id)strongSelf block:(void(^)(ArtUIStyle *style, id weakSelf))aBlock;

@end


@interface UIColor (ArtUIStyleApp)

+ (instancetype)artModule:(NSString *)aModule colorForKey:(NSString *)aColorKey;
+ (void)artModule:(NSString *)aModule colorForKey:(NSString *)aColorKey strongSelf:(id)strongSelf block:(void(^)(UIColor *color, id weakSelf))aBlock;


@end

@interface UIFont (ArtUIStyleApp)

+ (instancetype)artModule:(NSString *)aModule fontForKey:(NSString *)aFontKey;
+ (void)artModule:(NSString *)aModule fontForKey:(NSString *)aFontKey strongSelf:(id)strongSelf block:(void(^)(UIFont *font, id weakSelf))aBlock;


@end


@interface UIImage (ArtUIStyleApp)

+ (UIImage *)artModule:(NSString *)aModule imageString:(NSString *)aImageString;
+ (void)artModule:(NSString *)aModule imageString:(NSString *)aImageString strongSelf:(id)strongSelf block:(void(^)(UIImage *image, id weakSelf))aBlock;

@end

