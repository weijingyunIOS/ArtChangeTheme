//
//  UIImage+ArtDraw.m
//  ChangeTheme_OC
//
//  Created by weijingyun on 2017/8/25.
//  Copyright © 2017年 weijingyun. All rights reserved.
//

#import "UIImage+ArtDraw.h"

@implementation UIImage (ArtDraw)

/**
 以设置的颜色渲染图片
 
 @param aColor  渲染颜色
 @return 渲染后的图片
 */
- (UIImage *)art_tintedImageWithColor:(UIColor *)aColor {
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, false, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self drawInRect:rect];
    CGContextSetFillColorWithColor(context, aColor.CGColor);
    //设置透明度(值可根据需求更改)
    CGContextSetAlpha(context, 1);
    //设置混合模式
    CGContextSetBlendMode(context, kCGBlendModeSourceAtop);
    //设置位置大小
    CGContextFillRect(context, rect);
    
    //绘制图片
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    UIImage *darkImage = [UIImage imageWithCGImage:imageRef scale:self.scale orientation:UIImageOrientationUp];
    CGImageRelease(imageRef);
    
    //完成绘制
    UIGraphicsEndImageContext();
    return darkImage;
}

@end
