//
//  ArtModule1ViewController.m
//  ChangeTheme_OC
//
//  Created by weijingyun on 2017/8/21.
//  Copyright © 2017年 weijingyun. All rights reserved.
//

#import "ArtModule2ViewController.h"
#import "ArtUIStyleManager+UIStyleModule2.h"
#import "ArtUIStyleManager+UIStyleApp.h"

@interface ArtModule2ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *testImageView;

@end

@implementation ArtModule2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self configUI];
    [self configUI2];
}

- (void)configUI2 {
    [[ArtUIStyleManager shared] saveStrongSelf:self block:^(ArtModule2ViewController *weakSelf) {
        weakSelf.view.backgroundColor = [UIColor artAppForKey:kUIStyleAppVCBackground];
        weakSelf.testImageView.image = [[UIImage imageNamed:@"Module2_test"]art_tintedImageWithColor:[UIColor artModule2ForKey:kUIStyleModule2DrawColor ]];
    }];
}

- (void)configUI {
    [UIColor artAppForKey:kUIStyleAppVCBackground strongSelf:self block:^(UIColor *color, ArtModule2ViewController *weakSelf) {
        weakSelf.view.backgroundColor = color;
    }];
    
    [UIColor artModule2ForKey:kUIStyleModule2DrawColor strongSelf:self block:^(UIColor *color, ArtModule2ViewController *weakSelf) {
        weakSelf.testImageView.image = [[UIImage imageNamed:@"Module2_test"]art_tintedImageWithColor:color];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"ArtModule2ViewController"];
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
