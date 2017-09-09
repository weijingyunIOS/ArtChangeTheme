//
//  ArtUIStyleHotReloader.m
//  ChangeTheme_OC
//
//  Created by weijingyun on 2017/8/28.
//  Copyright © 2017年 weijingyun. All rights reserved.
//

#import "ArtUIStyleHotReloader.h"
#import "SGDirWatchdog.h"
#import "ArtUIStyleManager.h"
#import "NSObject+ArtPrefix.h"

@interface ArtUIStyleHotReloader ()

@property (nonatomic,assign) BOOL isHotReload;
@property (nonatomic, strong) NSMutableArray <SGDirWatchdog *>*watchDogs;

@end


@implementation ArtUIStyleHotReloader

+ (instancetype)shared
{
    static dispatch_once_t onceToken;
    static id shared = nil;
    dispatch_once(&onceToken, ^{
        shared = [self new];
    });
    return shared;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.watchDogs = [NSMutableArray new];
    }
    return self;
}

- (void)hotReloaderBundlePath:(NSString *)path {
#if TARGET_IPHONE_SIMULATOR
    SGDirWatchdog *watchDog =
    [[SGDirWatchdog alloc] initWithPath:path update:^{
        NSBundle *bundle = [NSBundle bundleWithPath:path];
        [[ArtUIStyleManager shared] reloadStyleBundle:bundle];
        NSLog(@"change======");
    }];
    [self.watchDogs addObject:watchDog];
#endif
}

- (void)hotMainReloaderByProjectPath:(NSString *)path {
#if TARGET_IPHONE_SIMULATOR
    NSArray <NSString *> *selArray = [[ArtUIStyleManager shared] art_getMethodByListPrefix:@"getHotReloaderStylePath_"];
    [selArray enumerateObjectsUsingBlock:^(NSString * _Nonnull selString, NSUInteger idx, BOOL * _Nonnull stop) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        NSString *stylePath = [[ArtUIStyleManager shared] performSelector:NSSelectorFromString(selString)];
#pragma clang diagnostic pop
        NSString *filePath = [path stringByAppendingPathComponent:stylePath];
        [self watchFilepath:filePath];
    }];
#endif
}

- (void)watchFilepath:(NSString *)filepath {
#if TARGET_IPHONE_SIMULATOR
    NSString *watchPath = [filepath stringByDeletingLastPathComponent];
    SGDirWatchdog *watchDog =
    [[SGDirWatchdog alloc] initWithPath:watchPath update:^{
        [[ArtUIStyleManager shared] addEntriesFromPath:filepath];
        [[ArtUIStyleManager shared] reload];
        NSLog(@"change======");
    }];
    [self.watchDogs addObject:watchDog];
#endif
}

- (void)startHotReloader{
#if TARGET_IPHONE_SIMULATOR
    [self watchStyleFile:YES];
#endif
}

- (void)endHotReloader{
#if TARGET_IPHONE_SIMULATOR
    [self watchStyleFile:NO];
#endif
}

-(void)watchStyleFile:(BOOL)watch
{
#if TARGET_IPHONE_SIMULATOR
    for (SGDirWatchdog *dog in self.watchDogs) {
        if (watch) {
            [dog start];
        }else{
            [dog stop];
        }
    }
    self.isHotReload = watch;
#endif
}

@end
