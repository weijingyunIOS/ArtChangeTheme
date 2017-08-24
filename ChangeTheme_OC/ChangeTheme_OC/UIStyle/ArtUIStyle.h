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

@property (nonatomic, strong) NSDictionary* style;

@end


@interface UIColor (ArtUIStyleApp)

+ (void)artModule:(NSString *)aModule colorForKey:(NSString *)aColorKey strongSelf:(id)strongSelf block:(void(^)(UIColor *color, id weakSelf))aBlock;

// 该方法不建议使用
+ (void)artModule:(NSString *)aModule colorForKey:(NSString *)aColorKey block:(id(^)(UIColor *))aBlock;

@end

@interface UIFont (ArtUIStyleApp)

+ (void)artModule:(NSString *)aModule fontForKey:(NSString *)aFontKey strongSelf:(id)strongSelf block:(void(^)(UIFont *font, id weakSelf))aBlock;

// 该方法不建议使用
+ (void)artModule:(NSString *)aModule fontForKey:(NSString *)aFontKey block:(id(^)(UIFont *))aBlock;

@end


@interface ArtLayoutInfo (ArtUIStyleApp)

+ (void)artModule:(NSString *)aModule layoutForKey:(NSString *)aLayoutKey strongSelf:(id)strongSelf block:(void(^)(ArtLayoutInfo *layoutInfo, id weakSelf))aBlock;

// 该方法不建议使用
+ (void)artModule:(NSString *)aModule layoutForKey:(NSString *)aLayoutKey block:(id(^)(ArtLayoutInfo *layoutInfo))aBlock;

@end


@interface UIImage (ArtUIStyleApp)

+ (void)artModule:(NSString *)aModule imageString:(NSString *)aImageString strongSelf:(id)strongSelf block:(void(^)(UIImage *image, id weakSelf))aBlock;

// 该方法不建议使用
+ (void)artModule:(NSString *)aModule imageString:(NSString *)aImageString block:(id(^)(UIImage *image))aBlock;

@end

