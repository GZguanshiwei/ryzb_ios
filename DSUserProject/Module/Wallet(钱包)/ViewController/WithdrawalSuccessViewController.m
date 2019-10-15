//
//  WithdrawalSuccessViewController.m
//  JMBaseProject
//
//  Created by Liuny on 2019/6/26.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "WithdrawalSuccessViewController.h"
#import "WalletViewController.h"

@interface WithdrawalSuccessViewController ()

@end

@implementation WithdrawalSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)initControl{
    
}

-(void)initData{
    self.title = @"提现申请成功";
}

#pragma mark - Actions
- (IBAction)backToWalletAction:(id)sender {
    UIViewController *backVC;
    for(UIViewController *vc in self.navigationController.viewControllers){
        if([vc isKindOfClass:[WalletViewController class]]){
            backVC = vc;
            break;
        }
    }
    if(backVC){
        [self.navigationController popToViewController:backVC animated:YES];
    }
}

@end
