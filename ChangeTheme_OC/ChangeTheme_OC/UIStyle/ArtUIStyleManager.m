//
//  ArtUIStyleManager.m
//  ChangeTheme_OC
//
//  Created by weijingyun on 2017/8/22.
//  Copyright © 2017年 weijingyun. All rights reserved.
//

#import "ArtUIStyleManager.h"
#import "NSObject+ArtPrefix.h"
#import "ArtThreadSafeArray.h"
#import "ArtThreadSafeDictionary.h"

NSString* const kArtUIStyleFontKey = @"font";
NSString* const kArtUIStyleColorKey = @"color";

NSString* const kArtUIStyleClearKey = @"kArtUIStyleClearKey";
NSString* const kArtUIStyleBlockKey = @"kArtUIStyleBlockKey";

typedef void (^ArtSaveBlock)(id weakSelf);

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

@property (nonatomic, strong) ArtThreadSafeDictionary* styles;
@property (nonatomic, strong) ArtThreadSafeArray *blocks;
@property (nonatomic, strong) NSCache *styleCache;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) dispatch_queue_t clearQueue;

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

- (instancetype)init
{
    if (self = [super init]) {
        [self config];
    }
    return self;
}

- (void)dealloc {
    [self.timer invalidate];
}

- (void)config {
    self.styles = [ArtThreadSafeDictionary new];
    self.blocks = [ArtThreadSafeArray new];
    self.styleCache = [NSCache new];
    self.styleCache.countLimit = 10;
    self.clearQueue = dispatch_queue_create("com.art.styleManager.clear", DISPATCH_QUEUE_SERIAL);
    [self getConfig];
    switch (self.styleType) {
        case EArtUIStyleTypeDefault:
        {
            [self reloadStyleBundle:[NSBundle mainBundle]];
        }
            break;
            
        case EArtUIStyleTypeBundle:
        {
            NSBundle *bundle = [NSBundle bundleWithPath:self.stylePath];
            [self reloadStyleBundle:bundle];
        }
            break;
            
        case EArtUIStyleTypeStylePath:
        {
            [self reloadStylePath:self.stylePath];
        }
            break;
            
        default:
            break;
    }
    self.clearInterval = 60.;
}

- (void)setClearInterval:(CGFloat)clearInterval {
    _clearInterval = clearInterval;
    [self.timer invalidate];
    if (clearInterval < 1) {
        return;
    }
    // 开启定时器清理已释放的--
    self.timer = [NSTimer scheduledTimerWithTimeInterval:clearInterval target:self selector:@selector(scheduledTime) userInfo:nil repeats:YES];
//    [NSTimer timerWithTimeInterval:clearInterval repeats:YES block:^(NSTimer * _Nonnull timer) {
//        dispatch_async(self.clearQueue, ^{
//            [weakSelf clearInvalidBlock];
//        });
//    }];
//    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)scheduledTime {
    dispatch_async(self.clearQueue, ^{
        [self clearInvalidBlock];
    });
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
    
#if DEBUG
    // 线程不一致该计算不准确只是打印看一下
    NSInteger count = allkey.count - self.blocks.count;
    if (count > 0) {
        NSLog(@"%tu 个无效的被清理",count);
    }
#endif
}

- (void)saveConfig {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@(self.styleType) forKey:@"ArtUIStyleManager_styleType"];
    [defaults setObject:self.stylePath forKey:@"ArtUIStyleManager_stylePath"];
    [defaults synchronize];
}

- (void)getConfig {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.styleType = [[defaults objectForKey:@"ArtUIStyleManager_styleType"] integerValue];
    NSString *path = [defaults objectForKey:@"ArtUIStyleManager_stylePath"];
    NSRange range = [path rangeOfString:@"Documents"];
    if (range.length > 0) {
        path = [path substringFromIndex:range.location + range.length];
        NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        path = [documentDirectory stringByAppendingPathComponent:path];
    }
    self.stylePath = path;
}

- (ArtUIStyle *)styleForKey:(NSString *)aKey {
    
    ArtUIStyle* style = [self.styleCache objectForKey:aKey];
    if (style == nil) {
        style = [[ArtUIStyle alloc] initWithStyle:[self.styles objectForKey:aKey]];
        [self.styleCache setObject:style forKey:aKey];
    }
    return style;
}

- (void)saveStrongSelf:(id)strongSelf block:(void(^)(id weakSelf))aBlock {
    
    NSAssert([NSThread isMainThread], @"界面相关操作请放主线程");
    // 使用弱引用
    NSDictionary *dic = @{kArtUIStyleClearKey:artMakeWeakReference(strongSelf),
                          kArtUIStyleBlockKey:aBlock};
    [self.blocks addObject:dic];
    if (aBlock) {
        aBlock(strongSelf);
    }
}

- (void)reloadStylePath:(NSString *)aStylePath {
    
    self.styleType = EArtUIStyleTypeStylePath;
    self.stylePath = aStylePath;
    [self saveConfig];
    
    [self reloadStyle:^(ArtUIStyleManager *manager) {
        [manager buildAppStyle:^(NSString *styleName) {
            
            NSString *path = [aStylePath stringByAppendingPathComponent:styleName];
            if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
                NSLog(@"waring--该bundle无 %@",styleName);
                path = [[NSBundle mainBundle] pathForResource:styleName ofType:nil];
            }
            [manager addEntriesFromPath:path];
        }];
    }];
}

- (void)reloadStyleBundleName:(NSString *)aStyleBundleName {
    NSString * bundlePath = [[ NSBundle mainBundle] pathForResource:aStyleBundleName ofType :@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    NSAssert(bundle != nil, @"bundle 不存在");
    [self reloadStyleBundle:bundle];
}

- (void)reloadStyleBundle:(NSBundle *)aStyleBundle {
    
    if (aStyleBundle == nil || aStyleBundle == [NSBundle mainBundle]) {
        self.styleType = EArtUIStyleTypeDefault;
        self.stylePath = nil;
    }else {
        self.styleType = EArtUIStyleTypeBundle;
        self.stylePath = aStyleBundle.bundlePath;
    }
    [self saveConfig];
    
    [self reloadStyle:^(ArtUIStyleManager *manager) {
        [manager buildAppStyle:^(NSString *styleName) {
            
            NSString *path = [aStyleBundle pathForResource:styleName ofType:nil];
            if (path.length <= 0) {
                NSLog(@"waring--该bundle无 %@",styleName);
                path = [[NSBundle mainBundle] pathForResource:styleName ofType:nil];
            }
            [manager addEntriesFromPath:path];
        }];
    }];
}

- (void)reloadStyle:(void(^)(ArtUIStyleManager *manager))aBlock {
    NSAssert([NSThread isMainThread], @"界面相关操作请放主线程");
    [self.styles removeAllObjects];
    if (aBlock) {
        aBlock(self);
    }
    [self reload];
}

// 对已有界面重新刷一遍
- (void)reload {
    [self.styleCache removeAllObjects];
    NSArray *blocks = [self.blocks copy];
    self.blocks = [ArtThreadSafeArray new];
    [blocks enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ArtSaveBlock block = obj[kArtUIStyleBlockKey];
        ArtWeakReference value = obj[kArtUIStyleClearKey];
        id key = weakReferenceNonretainedObjectValue(value);
        if (key && block) {
            [self saveStrongSelf:key block:block];
        }
    }];
}

- (void)addEntriesFromPath:(NSString *)aPath {
    [self.styles addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:aPath]];
}


- (void)buildAppStyle:(void(^)(NSString *styleName))aBlock
{
    NSArray <NSString *> *selArray = [self art_getMethodByListPrefix:@"getStyleName_"];
    [selArray enumerateObjectsUsingBlock:^(NSString * _Nonnull selString, NSUInteger idx, BOOL * _Nonnull stop) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        NSString *styleName = [self performSelector:NSSelectorFromString(selString)];
#pragma clang diagnostic pop
        if (aBlock) {
            aBlock(styleName);
        }
    }];
}

@end
