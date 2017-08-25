//
//  ArtModule3ViewController.m
//  ChangeTheme_OC
//
//  Created by weijingyun on 2017/8/21.
//  Copyright © 2017年 weijingyun. All rights reserved.
//

#import "ArtModule3ViewController.h"
#import "ArtUIStyleManager+UIStyleModule3.h"
#import "ArtUIStyleManager+UIStyleApp.h"

@interface ArtModule3ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *testImageView;

@end

@implementation ArtModule3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}

- (void)configUI {
    [UIColor artAppForKey:kUIStyleAppVCBackground strongSelf:self block:^(UIColor *color, ArtModule3ViewController *weakSelf) {
        weakSelf.view.backgroundColor = color;
    }];
    
    self.testImageView.image = [[UIImage imageNamed:@"Module3_test"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [UIColor artModule3ForKey:kUIStyleModule3TintColor strongSelf:self block:^(UIColor *color, ArtModule3ViewController *weakSelf) {
        weakSelf.testImageView.tintColor = color;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"ArtModule3ViewController"];
    vc.hidesBottomBarWhenPushed = YES;
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
