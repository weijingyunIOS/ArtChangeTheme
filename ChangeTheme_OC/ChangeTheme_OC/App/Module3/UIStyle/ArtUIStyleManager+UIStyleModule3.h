//
//  ArtUIStyleManager+UIStyleModule3.h
//  ChangeTheme_OC
//
//  Created by weijingyun on 2017/8/22.
//  Copyright © 2017年 weijingyun. All rights reserved.
//

#import "ArtUIStyleManager.h"

@interface ArtUIStyleManager (UIStyleModule3)

- (NSString *)getStyleName_Module3;

@end


#define kUIStyleModule3TintColor  @"TintColor" // 备注

@interface UIColor (UIStyleModule3)

+ (UIColor *)artModule3ForKey:(NSString *)aColorKey;
+ (void)artModule3ForKey:(NSString *)aColorKey strongSelf:(id)strongSelf block:(void(^)(UIColor *color, id weakSelf))aBlock;

@end


@interface UIFont (UIStyleModule3)

+ (UIFont *)artModule3ForKey:(NSString *)aFontKey;
+ (void)artModule3ForKey:(NSString *)aFontKey strongSelf:(id)strongSelf block:(void(^)(UIFont *color, id weakSelf))aBlock;

@end
