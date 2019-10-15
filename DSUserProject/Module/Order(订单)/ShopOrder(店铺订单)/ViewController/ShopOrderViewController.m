//
//  ShopOrderViewController.m
//  JMBaseProject
//
//  Created by Liuny on 2019/6/27.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "ShopOrderViewController.h"
#import "ShopOrderPageViewController.h"

@interface ShopOrderViewController ()
@property (nonatomic, weak) ShopOrderPageViewController *orderPageVC;
@end

@implementation ShopOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)initControl{
    self.title = @"我的订单";
    
}

-(void)initData{
    self.orderPageVC.selectIndex = (int)self.selectIndex;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"pageViewController"]){
        self.orderPageVC = segue.destinationViewController;
    }
}

@end
