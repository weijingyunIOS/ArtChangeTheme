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
- (nullable NSArray <NSString *> *)art_getMethodByListPrefix:(NSString *_Nonnull)prefix;
+ (nullable NSArray <NSString *> *)art_getMethodByListPrefix:(NSString *_Nonnull)prefix;

@end
