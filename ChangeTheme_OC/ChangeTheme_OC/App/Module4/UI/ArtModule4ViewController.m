//
//  ArtModule4ViewController.m
//  ChangeTheme_OC
//
//  Created by weijingyun on 2017/8/21.
//  Copyright © 2017年 weijingyun. All rights reserved.
//

#import "ArtModule4ViewController.h"
#import "ArtUIStyleManager+UIStyleModule4.h"
#import "ArtUIStyleManager.h"
@interface ArtModule4ViewController ()

@end

@implementation ArtModule4ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    __weak typeof(self) weakSelf = self;
//    [UIColor artModule4ForKey:kUIStyleModule4MainLabel block:^id(UIColor *color) {
//        weakSelf.view.backgroundColor = color;
//        return weakSelf;
//    }];
    
    [UIColor artModule4ForKey:kUIStyleModule4MainLabel strongSelf:self block:^(UIColor *color, ArtModule4ViewController *weakSelf) {
        weakSelf.view.backgroundColor = color;
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    ArtModule4ViewController *vc = [ArtModule4ViewController new];
    [self.navigationController pushViewController:vc animated:YES];
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
