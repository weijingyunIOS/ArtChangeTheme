//
//  ArtModule1ViewController.m
//  ChangeTheme_OC
//
//  Created by weijingyun on 2017/8/21.
//  Copyright © 2017年 weijingyun. All rights reserved.
//

#import "ArtModule1ViewController.h"
#import "ArtUIStyleManager+UIStyleModule1.h"
#import "ArtUIStyleManager+UIStyleApp.h"

@interface ArtModule1ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *testImage;
@property (weak, nonatomic) IBOutlet UILabel *testMainLabel;
@property (weak, nonatomic) IBOutlet UIView *testview;

@end

@implementation ArtModule1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}

- (void)configUI {
    
    [UIColor artAppForKey:kUIStyleAppVCBackground strongSelf:self block:^(UIColor *color, ArtModule1ViewController *weakSelf) {
        weakSelf.view.backgroundColor = color;
    }];
    
    [UIColor artAppForKey:kUIStyleAppMainLabel strongSelf:self block:^(UIColor *color, ArtModule1ViewController *weakSelf) {
        weakSelf.testMainLabel.textColor = color;
    }];
    
    [UIFont artAppForKey:kUIStyleAppMainLabel strongSelf:self block:^(UIFont *font, ArtModule1ViewController *weakSelf) {
        weakSelf.testMainLabel.font = font;
    }];
    
    [UIColor artModule1ForKey:kUIStyleModule1Test strongSelf:self block:^(UIColor *color, ArtModule1ViewController *weakSelf) {
        weakSelf.testview.backgroundColor = color;
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [[ArtUIStyleManager shared] reloadStyleBundleName:@"styleBundle1"];
//    ArtModule1ViewController *vc = [ArtModule1ViewController new];
//    [self.navigationController pushViewController:vc animated:YES];
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
