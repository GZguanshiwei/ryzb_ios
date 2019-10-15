//
//  PaySuccessViewController.m
//  JMBaseProject
//
//  Created by Liuny on 2019/1/5.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "PaySuccessViewController.h"
#import "OrderDetailViewController.h"

@interface PaySuccessViewController ()

@end

@implementation PaySuccessViewController

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
- (IBAction)seeOrderAction:(id)sender {
    OrderDetailViewController *detailVC = [[OrderDetailViewController alloc] initWithStoryboardName:@"Order"];
    detailVC.orderId = self.orderId;
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (IBAction)goHomeAction:(id)sender {
    //回到首页
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
