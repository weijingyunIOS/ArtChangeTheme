//
//  ArtModule1ViewController.m
//  ChangeTheme_OC
//
//  Created by weijingyun on 2017/8/21.
//  Copyright © 2017年 weijingyun. All rights reserved.
//

#import "ArtModule2ViewController.h"
#import "ArtUIStyleManager+UIStyleModule2.h"

@interface ArtModule2ViewController ()

@end

@implementation ArtModule2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    __weak typeof(self) weakSelf = self;
//    [UIColor artModule1ForKey:kUIStyleModule1MainLabel block:^id(UIColor *color) {
//        weakSelf.view.backgroundColor = color;
//        return weakSelf;
//    }];
    
    [UIColor artModule2ForKey:kUIStyleModule1MainLabel strongSelf:self block:^(UIColor *color, ArtModule2ViewController *weakSelf) {
        weakSelf.view.backgroundColor = color;
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [[ArtUIStyleManager shared] reloadStyleBundleName:@"styleBundle1"];
//    NSString * bundlePath = [[ NSBundle mainBundle] pathForResource:@"styleBundle1" ofType :@"bundle"];
//    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
//    [[ArtUIStyleManager shared] reloadStyleBundle:bundle];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc {
    NSLog(@"正常释放 %s",__func__);
}

@end
