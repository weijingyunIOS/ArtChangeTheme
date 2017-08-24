//
//  ArtUIStyleManager+UIStyleApp.h
//  ChangeTheme_OC
//
//  Created by weijingyun on 2017/8/24.
//  Copyright © 2017年 weijingyun. All rights reserved.
//

#import "ArtUIStyleManager.h"

@interface ArtUIStyleManager (UIStyleApp)

- (NSString *)getStyleName_App;

@end


#define kUIStyleAppVCBackground     @"vcBackground" // 备注
#define kUIStyleAppMainLabel        @"MainLabel" // 备注
#define kUIStyleAppViceLabel        @"ViceLabel" // 备注

@interface UIColor (UIStyleApp)

+ (void)artAppForKey:(NSString *)aColorKey strongSelf:(id)strongSelf block:(void(^)(UIColor *color, id weakSelf))aBlock;

@end


@interface UIFont (UIStyleApp)

+ (void)artAppForKey:(NSString *)aFontKey strongSelf:(id)strongSelf block:(void(^)(UIFont *font, id weakSelf))aBlock;

@end
