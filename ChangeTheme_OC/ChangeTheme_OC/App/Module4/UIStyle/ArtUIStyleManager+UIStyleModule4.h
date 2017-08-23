//
//  ArtUIStyleManager+UIStyleModule4.h
//  ChangeTheme_OC
//
//  Created by weijingyun on 2017/8/22.
//  Copyright © 2017年 weijingyun. All rights reserved.
//

#import "ArtUIStyleManager.h"

@interface ArtUIStyleManager (UIStyleModule4)

- (NSString *)getStyleName_Module4;

@end


#define kUIStyleModule4MainLabel  @"MainLabel" // 备注

@interface UIColor (UIStyleModule4)

+ (void)artModule4ForKey:(NSString *)aColorKey strongSelf:(id)strongSelf block:(void(^)(UIColor *color, id weakSelf))aBlock;

@end


@interface UIFont (UIStyleModule4)

+ (void)artModule4ForKey:(NSString *)aFontKey block:(id(^)(UIFont *))aBlock;

@end
