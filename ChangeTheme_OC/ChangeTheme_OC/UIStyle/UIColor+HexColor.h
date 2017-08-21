//
//  UIColor+HexColor.h
//  ChangeTheme_OC
//
//  Created by weijingyun on 2017/8/21.
//  Copyright © 2017年 weijingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexColor)

+ (UIColor *)art_colorWithHexString:(NSString *)stringToConvert alpha:(CGFloat)alpha;

@end
