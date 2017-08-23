//
//  ArtUIStyleManager+UIStyleModule1.h
//  ChangeTheme_OC
//
//  Created by weijingyun on 2017/8/22.
//  Copyright © 2017年 weijingyun. All rights reserved.
//

#import "ArtUIStyleManager.h"

@interface ArtUIStyleManager (UIStyleModule2)

- (NSString *)getStyleName_Module2;

@end


#define kUIStyleModule1MainLabel  @"MainLabel" // 备注

@interface UIColor (UIStyleModule2)

+ (void)artModule2ForKey:(NSString *)aColorKey strongSelf:(id)strongSelf block:(void(^)(UIColor *color, id weakSelf))aBlock;

@end


@interface UIFont (UIStyleModule2)

+ (void)artModule2ForKey:(NSString *)aFontKey block:(id(^)(UIFont *))aBlock;

@end
