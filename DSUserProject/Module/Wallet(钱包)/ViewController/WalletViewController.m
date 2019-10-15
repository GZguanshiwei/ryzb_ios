//
//  WalletViewController.m
//  JMBaseProject
//
//  Created by Liuny on 2019/6/26.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "WalletViewController.h"
#import "WalletDetailsViewController.h"
#import "WithdrawalViewController.h"

@interface WalletViewController ()
@property (weak, nonatomic) IBOutlet UILabel *canWithdrawalMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *waitPayMoneyLabel;
@property (weak, nonatomic) IBOutlet UIView *topView;

@end

@implementation WalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestBlance];
}

-(void)initControl{
    self.topView.backgroundColor = kColorMain;
}

-(void)initData{
    self.title = @"我的钱包";
}

#pragma mark - Navigation
-(UIImage *)jmNavigationBarRightButtonImage:(UIButton *)rightButton navigationBar:(JMNavigationBar *)navigationBar{
    [JMCommonMethod navigationItemSet:rightButton fontColor:[UIColor whiteColor]];
    [rightButton setTitle:@"明细" forState:UIControlStateNormal];
    return nil;
}

-(void)rightButtonEvent:(UIButton *)sender navigationBar:(JMNavigationBar *)navigationBar{
    WalletDetailsViewController *detailVC = [[WalletDetailsViewController alloc] initWithStoryboardName:@"Wallet"];
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - Actions
- (IBAction)withdrawalAction:(id)sender {
    //提现
    WithdrawalViewController *withdrawalVC = [[WithdrawalViewController alloc] initWithStoryboardName:@"Wallet"];
    [self.navigationController pushViewController:withdrawalVC animated:YES];
}

#pragma mark - 网络
-(void)requestBlance{
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [[JMRequestManager sharedManager] POST:kUrlAccountBlance parameters:params completion:^(JMBaseResponse *response) {
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
            NSDictionary *dataDic = response.responseObject[@"data"];
            JMLoginUserModel *loginUser = [JMProjectManager sharedJMProjectManager].loginUser;
            loginUser.withdrawBlance = [dataDic getJsonValue:@"withdrawable"];
            self.canWithdrawalMoneyLabel.text = loginUser.withdrawBlance;
            self.waitPayMoneyLabel.text = [dataDic getJsonValue:@"unbooked"];
        }
    }];
}

@end
