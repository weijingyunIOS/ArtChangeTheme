//
//  UIImage+ArtDraw.h
//  ChangeTheme_OC
//
//  Created by weijingyun on 2017/8/25.
//  Copyright © 2017年 weijingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ArtDraw)

/**
 以设置的颜色渲染图片
 
 @param aColor  渲染颜色
 @return 渲染后的图片
 */
- (UIImage *)art_tintedImageWithColor:(UIColor *)aColor;

@end
