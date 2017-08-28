//
//  ArtUIStyle.h
//  ChangeTheme_OC
//
//  Created by weijingyun on 2017/8/21.
//  Copyright © 2017年 weijingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArtLayoutInfo.h"

@interface ArtUIStyle : NSObject

- (id)initWithStyle:(NSDictionary *)aStyle;

@end


@interface UIColor (ArtUIStyleApp)

+ (UIColor *)artModule:(NSString *)aModule colorForKey:(NSString *)aColorKey;
+ (void)artModule:(NSString *)aModule colorForKey:(NSString *)aColorKey strongSelf:(id)strongSelf block:(void(^)(UIColor *color, id weakSelf))aBlock;


@end

@interface UIFont (ArtUIStyleApp)

+ (UIFont *)artModule:(NSString *)aModule fontForKey:(NSString *)aFontKey;
+ (void)artModule:(NSString *)aModule fontForKey:(NSString *)aFontKey strongSelf:(id)strongSelf block:(void(^)(UIFont *font, id weakSelf))aBlock;


@end


@interface ArtLayoutInfo (ArtUIStyleApp)

+ (ArtLayoutInfo *)artModule:(NSString *)aModule layoutForKey:(NSString *)aLayoutKey;
+ (void)artModule:(NSString *)aModule layoutForKey:(NSString *)aLayoutKey strongSelf:(id)strongSelf block:(void(^)(ArtLayoutInfo *layoutInfo, id weakSelf))aBlock;

@end


@interface UIImage (ArtUIStyleApp)

+ (UIImage *)artModule:(NSString *)aModule imageString:(NSString *)aImageString;
+ (void)artModule:(NSString *)aModule imageString:(NSString *)aImageString strongSelf:(id)strongSelf block:(void(^)(UIImage *image, id weakSelf))aBlock;

@end

