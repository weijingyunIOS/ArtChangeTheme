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


#define kUIStyleModule3MainLabel  @"MainLabel" // 备注

@interface UIColor (UIStyleModule3)

+ (void)artModule3ForKey:(NSString *)aColorKey strongSelf:(id)strongSelf block:(void(^)(UIColor *color, id weakSelf))aBlock;

@end


@interface UIFont (UIStyleModule3)

+ (void)artModule3ForKey:(NSString *)aFontKey block:(id(^)(UIFont *))aBlock;

@end
