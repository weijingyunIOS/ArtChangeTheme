//
//  NSObject+RunTime.m
//  ArtStudio
//
//  Created by weijingyun on 2017/1/5.
//  Copyright © 2017年 kimziv. All rights reserved.
//

#import "NSObject+ArtPrefix.h"
#import <objc/runtime.h>

@implementation NSObject (ArtPrefix)

- (NSArray <NSString *> *)art_getMethodByListPrefix:(NSString *)prefix {
    return [[self class] art_getMethodByListPrefix:prefix];
}

+ (NSArray <NSString *> *)art_getMethodByListPrefix:(NSString *)prefix {
    
    Class currentClass = [self class];
    NSMutableArray <NSString *> *selArrayM = [[NSMutableArray alloc] init];
    while (currentClass) {
        unsigned int methodCount;
        Method *methodList = class_copyMethodList(currentClass, &methodCount);
        unsigned int i = 0;
        for (; i < methodCount; i++) {
            
            SEL sel = method_getName(methodList[i]);
            NSString *methodString = [NSString stringWithCString:sel_getName(sel) encoding:NSUTF8StringEncoding];
            if ([methodString hasPrefix:prefix]) {
                [selArrayM addObject:methodString];
            }
        }
        
        free(methodList);
        currentClass = class_getSuperclass(currentClass);
    }
    
    if (selArrayM.count <= 0) {
        return nil;
    }
    
#if DEBUG
    for (int i = 0; i < selArrayM.count; i ++) {
        for (int j = i + 1; j < selArrayM.count; j ++) {
            NSString *stri = selArrayM[i];
            NSString *strj = selArrayM[j];
            if ([stri isEqualToString:strj]) {
                NSAssert(NO, @"请检查有同名分类名注意修改-- %@",stri);
            }
        }
    }
#endif
    return [selArrayM copy];
}

@end
