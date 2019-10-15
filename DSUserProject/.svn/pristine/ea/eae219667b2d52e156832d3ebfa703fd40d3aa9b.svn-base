//
//  OrderViewController.m
//  JMBaseProject
//
//  Created by Liuny on 2019/4/23.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "OrderViewController.h"
#import "OrderPageViewController.h"

@interface OrderViewController ()
@property (nonatomic, weak) OrderPageViewController *orderPageVC;
@end

@implementation OrderViewController

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
