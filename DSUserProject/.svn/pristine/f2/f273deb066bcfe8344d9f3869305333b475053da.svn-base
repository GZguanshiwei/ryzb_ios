//
//  PayFailViewController.m
//  JMBaseProject
//
//  Created by Liuny on 2019/1/5.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "PayFailViewController.h"

@interface PayFailViewController ()

@end

@implementation PayFailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)initControl{
    self.title = @"支付结果";
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)initData{
    
}

#pragma mark - UINavigation
-(void)leftButtonEvent:(UIButton *)sender navigationBar:(JMNavigationBar *)navigationBar{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - Actions
- (IBAction)payAgainAction:(id)sender {
    //重新支付
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)goHomeAction:(id)sender {
    //回到首页
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
