//
//  ArtTabBarController.m
//  ChangeTheme_OC
//
//  Created by weijingyun on 2017/9/7.
//  Copyright © 2017年 weijingyun. All rights reserved.
//

#import "ArtTabBarController.h"
#import "ArtUIStyleManager.h"
#import <SSZipArchive/SSZipArchive.h>

@interface ArtTabBarController ()<UIActionSheetDelegate>

@end

@implementation ArtTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 设置允许摇一摇功能
    [UIApplication sharedApplication].applicationSupportsShakeToEdit = YES;
    // 并让自己成为第一响应者
    [self becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0) {
    
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0) {
    if (event.subtype == UIEventSubtypeMotionShake) { // 判断是否是摇动结束
//        NSLog(@"摇动结束");
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"摇一摇" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"刷新" otherButtonTitles:nil];
        [sheet showInView:self.view];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex NS_DEPRECATED_IOS(2_0, 8_3) __TVOS_PROHIBITED {
    if (buttonIndex != 0) {
        return;
    }
    NSLog(@"刷新");
    NSString *urlString = @"http://172.16.40.100:80/resources/style.zip";
    NSURL * url = [NSURL URLWithString:urlString];
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *zipPath = [documentDirectory stringByAppendingPathComponent:@"style.zip"];
    [[NSFileManager defaultManager] removeItemAtPath:zipPath error:nil];
    [data writeToFile:zipPath atomically:YES];
    
    NSString *toPath = [documentDirectory stringByAppendingPathComponent:@"style"];
    [[NSFileManager defaultManager] removeItemAtPath:toPath error:nil];
    NSError *error = nil;
    [SSZipArchive unzipFileAtPath:zipPath toDestination:documentDirectory overwrite:YES password:nil error:&error];
    if (error) {
        return;
    }
    [[ArtUIStyleManager shared] reloadStylePath:toPath];
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0) {
   
}

@end
