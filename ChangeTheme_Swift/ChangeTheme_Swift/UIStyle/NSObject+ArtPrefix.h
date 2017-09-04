//
//  NSObject+RunTime.h
//  ArtStudio
//
//  Created by weijingyun on 2017/1/5.
//  Copyright © 2017年 kimziv. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ArtPrefix)

// 获取固定前缀的所有方法名
- (NSArray <NSString *> *)art_getMethodByListPrefix:(NSString *)prefix;
+ (NSArray <NSString *> *)art_getMethodByListPrefix:(NSString *)prefix;

@end
