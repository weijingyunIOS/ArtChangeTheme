//
//  ArtUIStyleManager+UIStyleModule1.h
//  ChangeTheme_OC
//
//  Created by weijingyun on 2017/8/22.
//  Copyright © 2017年 weijingyun. All rights reserved.
//

#import "ArtUIStyleManager.h"

@interface ArtUIStyleManager (UIStyleModule1)

- (NSString *)getStyleName_Module1;

@end


#define kUIStyleModule1Test  @"Test" // 备注

@interface UIColor (UIStyleModule1)

+ (void)artModule1ForKey:(NSString *)aColorKey strongSelf:(id)strongSelf block:(void(^)(UIColor *color, id weakSelf))aBlock;

@end


@interface UIFont (UIStyleModule1)

+ (void)artModule1ForKey:(NSString *)aFontKey block:(id(^)(UIFont *))aBlock;

@end
