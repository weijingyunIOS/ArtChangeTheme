//
//  ArtModule4ViewController.m
//  ChangeTheme_OC
//
//  Created by weijingyun on 2017/8/21.
//  Copyright © 2017年 weijingyun. All rights reserved.
//

#import "ArtModule4ViewController.h"
#import "ArtUIStyleManager+UIStyleModule4.h"
#import "ArtUIStyleManager+UIStyleApp.h"

@interface ArtModule4ViewController ()

@property (weak, nonatomic) IBOutlet UIView *testview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *testviewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *testviewWidth;
@property (weak, nonatomic) IBOutlet UIButton *defaultBtn;
@property (weak, nonatomic) IBOutlet UIButton *bundlebtn;

@end

@implementation ArtModule4ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self configUI];
    [self configUI2];
}

- (void)configUI2 {
    [[ArtUIStyleManager shared] saveStrongSelf:self block:^(ArtModule4ViewController *weakSelf) {
        weakSelf.view.backgroundColor = [UIColor artAppForKey:kUIStyleAppVCBackground];
        weakSelf.testview.backgroundColor = [UIColor artModule4ForKey:kUIStyleModule4Test];
        
        ArtLayoutInfo *layoutInfo = [ArtLayoutInfo artModule4ForKey:kUIStyleModule4Test];
        weakSelf.testviewWidth.constant = layoutInfo.width;
        weakSelf.testviewHeight.constant = layoutInfo.height;
        
    }];
}

- (void)configUI {
    [UIColor artAppForKey:kUIStyleAppVCBackground strongSelf:self block:^(UIColor *color, ArtModule4ViewController *weakSelf) {
        weakSelf.view.backgroundColor = color;
    }];
    
    [UIColor artModule4ForKey:kUIStyleModule4Test strongSelf:self block:^(UIColor *color, ArtModule4ViewController *weakSelf) {
        weakSelf.testview.backgroundColor = color;
    }];
    
    [ArtLayoutInfo artModule4ForKey:kUIStyleModule4Test strongSelf:self block:^(ArtLayoutInfo *layoutInfo, ArtModule4ViewController *weakSelf) {
        weakSelf.testviewWidth.constant = layoutInfo.width;
        weakSelf.testviewHeight.constant = layoutInfo.height;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)defaultClick:(id)sender {
    [[ArtUIStyleManager shared] reloadStyleBundle:[NSBundle mainBundle]];
}

- (IBAction)bundleClick:(id)sender {
    [[ArtUIStyleManager shared] reloadStyleBundleName:@"styleBundle1"];
}

- (IBAction)downPathClick:(id)sender {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *toPath = [documentDirectory stringByAppendingPathComponent:@"stylePath"];
    
    
    [[NSFileManager defaultManager] removeItemAtPath:toPath error:nil];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"styleBundle1" ofType:@"bundle"];
    
    NSError *error;
    [[NSFileManager defaultManager] copyItemAtPath:path toPath:toPath error:&error];
    
    [[ArtUIStyleManager shared] reloadStylePath:toPath];
    
}

- (IBAction)downBundleClick:(id)sender {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *toPath = [documentDirectory stringByAppendingPathComponent:@"styleBundle.bundle"];
    
    
    [[NSFileManager defaultManager] removeItemAtPath:toPath error:nil];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"styleBundle1" ofType:@"bundle"];
    
    NSError *error;
    [[NSFileManager defaultManager] copyItemAtPath:path toPath:toPath error:&error];
    
    NSBundle *bundle = [NSBundle bundleWithPath:toPath];
    
    [[ArtUIStyleManager shared] reloadStyleBundle:bundle];
}


- (void)dealloc {
    NSLog(@"正常释放 %s",__func__);
}

@end
