//
//  ArtUIStyleManager.m
//  ChangeTheme_OC
//
//  Created by weijingyun on 2017/8/22.
//  Copyright © 2017年 weijingyun. All rights reserved.
//

#import "ArtUIStyleManager.h"
NSString* const kArtUIStyleFontKey = @"font";
NSString* const kArtUIStyleColorKey = @"color";

NSString* const kArtUIStyleClearKey = @"kArtUIStyleClearKey";
NSString* const kArtUIStyleBlockKey = @"kArtUIStyleBlockKey";

typedef void (^ArtSaveBlock)(void);

typedef id (^ArtWeakReference)(void);

ArtWeakReference artMakeWeakReference(id object) {
    __weak id weakref = object;
    return ^{
        return weakref;
    };
}

id weakReferenceNonretainedObjectValue(ArtWeakReference ref) {
    return ref ? ref() : nil;
}

#pragma mark - ArtUIStyleManager

@interface ArtUIStyleManager ()

@property (nonatomic, strong) NSMutableDictionary* styles;
@property (nonatomic, strong) NSMutableArray<NSDictionary *> *blocks;

@end

@implementation ArtUIStyleManager

+ (instancetype)shared
{
    static dispatch_once_t onceToken;
    static id shared = nil;
    dispatch_once(&onceToken, ^{
        shared = [self new];
    });
    return shared;
}

- (id)init
{
    self = [super init];
    
    self.styles = [NSMutableDictionary dictionary];
    self.blocks = [NSMutableArray new];
    [self build];
    
    return self;
}

- (void)saveKey:(id)aKey block:(void(^)())aBlock {
    
    NSAssert([NSThread isMainThread], @"界面相关操作请放主线程");
    
    // 使用弱引用
    NSDictionary *dic = @{kArtUIStyleClearKey:artMakeWeakReference(aKey),
                          kArtUIStyleBlockKey:aBlock};
    [self.blocks addObject:dic];
    [self clearInvalidBlock];
}

// 清理无效的，已被释放的block
- (void)clearInvalidBlock {
    NSArray<NSDictionary *> *allkey = [self.blocks copy];
    [allkey enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ArtWeakReference value = obj[kArtUIStyleClearKey];
        id key = weakReferenceNonretainedObjectValue(value);
        if (key == nil) {
            [self.blocks removeObject:obj];
        }
    }];
}

- (void)reloadStylePath:(NSString *)aStylePath {
    [self reloadStyle:^(ArtUIStyleManager *manager) {
        
    }];
}

- (void)reloadStyleBundle:(NSBundle *)aStyleBundle {
    [self reloadStyle:^(ArtUIStyleManager *manager) {
        
    }];
}

- (void)reloadStyle:(void(^)(ArtUIStyleManager *manager))aBlock {
    NSAssert([NSThread isMainThread], @"界面相关操作请放主线程");
    [self.styles removeAllObjects];
    
    if (aBlock) {
        aBlock(self);
    }
    
    NSArray *blocks = [self.blocks copy];
    self.blocks = [NSMutableArray new];
    [blocks enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ArtSaveBlock block = obj[kArtUIStyleBlockKey];
        if (block) {
            block();
        }
    }];
}

- (void)addEntriesFromPath:(NSString *)aPath {
    [self.styles addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:aPath]];
}


- (void)build
{
    [self buildAppStyle];
}


- (void)buildAppStyle
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Module1Style" ofType:@"plist"];
    [self addEntriesFromPath:path];
}

@end
