//
//  ArtThreadSafeArray.m
//  ArtBox
//
//  Created by leoliu on 16/7/3.
//  Copyright © 2016年 zhaoguogang. All rights reserved.
//

#import "ArtThreadSafeArray.h"
#define INIT(...) self = super.init; \
if (!self) return nil; \
__VA_ARGS__; \
if (!_arr) return nil; \
_lock = dispatch_semaphore_create(1); \
return self;

#define LOCK(...) dispatch_semaphore_wait(self->_lock, DISPATCH_TIME_FOREVER); \
__VA_ARGS__; \
dispatch_semaphore_signal(self->_lock);

@implementation ArtThreadSafeArray{
    NSMutableArray *_arr;  //Subclass a class cluster...
    dispatch_semaphore_t _lock;
}

- (instancetype)init {
    INIT(_arr = [[NSMutableArray alloc] init]);
}

- (instancetype)initWithCapacity:(NSUInteger)numItems {
    INIT(_arr = [[NSMutableArray alloc] initWithCapacity:numItems]);
}

- (NSUInteger)count {
    LOCK(NSUInteger c = _arr.count);
    return c;
}

- (id)objectAtIndex:(NSUInteger)index {
    LOCK(
        id o = nil;
        if(index < _arr.count) {
            o = [_arr objectAtIndex:index];
        }
    );
    return o;
}

- (void)addObject:(id)anObject
{
    if (anObject == nil) {
        return;
    }
    LOCK([_arr addObject:anObject]);
}

- (void)insertObject:(id)anObject atIndex:(NSUInteger)index
{
    if (anObject == nil) {
        return;
    }
    LOCK([_arr insertObject:anObject atIndex:index]);
}

- (void)removeLastObject
{
    LOCK([_arr removeLastObject]);
}

- (void)removeObjectAtIndex:(NSUInteger)index
{
    LOCK([_arr removeObjectAtIndex:index]);
}

- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject
{
    LOCK([_arr replaceObjectAtIndex:index withObject:anObject]);
}

- (void)removeAllObjects
{
    LOCK([_arr removeAllObjects]);
}

- (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)idx
{
    if (obj == nil) {
        return;
    }
    LOCK([_arr setObject:obj atIndexedSubscript:idx]);
}

- (id)objectAtIndexedSubscript:(NSUInteger)idx
{
    LOCK(id o = [_arr objectAtIndexedSubscript:idx]);
    return o;
}

@end
