//
//  WithdrawalViewController.m
//  JMBaseProject
//
//  Created by Liuny on 2019/6/26.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "WithdrawalViewController.h"
#import "WithdrawalSuccessViewController.h"
#import "WalletChoiceCashController.h"
@interface WithdrawalViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *moneyTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *bankNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *bankBranchNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *cardIdTextField;

@property (weak, nonatomic) IBOutlet UILabel *showFeeLabel;
@property (assign, nonatomic) NSInteger feeRatio;
@property (assign, nonatomic) float maxMoney;
@property (weak, nonatomic) IBOutlet UIImageView *typeImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lableConstraint;
@property (strong, nonatomic) IBOutlet UILabel *accountLabel;
//选中提现账户id
@property (nonatomic, strong) NSString *selectAccountId;
@end

@implementation WithdrawalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)initControl{
    self.moneyTextField.delegate = self;
}

-(void)initData{
    self.title = @"申请提现";
//    JMLoginUserModel *loginUser = [JMProjectManager sharedJMProjectManager].loginUser;
//    self.moneyTextField.placeholder = [NSString stringWithFormat:@"可提现金额%.2f元",loginUser.withdrawBlance.floatValue];
    [self requestRatio];
}

#pragma mark - Actions
- (IBAction)commitAction:(id)sender {
    [self.view endEditing:YES];
    NSString *money = self.moneyTextField.text;
    if(money.doubleValue <= 0){
        [JMProgressHelper toastInWindowWithMessage:@"请输入正确的提现金额"];
        return;
    }
    if(money.doubleValue > self.maxMoney){
        [JMProgressHelper toastInWindowWithMessage:@"输入金额超过可提现金额"];
        return;
    }
    if (JMIsEmpty(self.selectAccountId)) {
        [JMProgressHelper toastInWindowWithMessage:@"请选择提现账户"];
        return;
    }
    [self requestWithdraw];
}

-(void)goSuccessVC{
    WithdrawalSuccessViewController *successVC = [[WithdrawalSuccessViewController alloc] initWithStoryboardName:@"Wallet"];
    [self.navigationController pushViewController:successVC animated:YES];
}

- (IBAction)allAction:(id)sender {
    //全部提现
    self.moneyTextField.text = [NSString stringWithFormat:@"%.2f",self.maxMoney];
    self.showFeeLabel.text = [NSString stringWithFormat:@"额外扣除手续费：￥%.2f",self.maxMoney*(self.feeRatio/100.0)];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    NSString *money = self.moneyTextField.text;
    self.showFeeLabel.text = [NSString stringWithFormat:@"额外扣除手续费：￥%.2f",money.doubleValue*(self.feeRatio/100.0)];
    return YES;
}

#pragma mark -  选择提现账户
- (IBAction)choiceCashAction:(id)sender {
    WalletChoiceCashController *choiceVc = [[WalletChoiceCashController alloc] initWithStoryboardName:@"Wallet"];
    choiceVc.choiceCashAccountBlock = ^(WalletAccountListModel * _Nonnull model) {
        self.typeImageView.hidden = NO;
        self.lableConstraint.constant = 60;
        self.selectAccountId = model.modelId;
        self.accountLabel.text = model.account;
        //提现方式1银行卡2微信3支付宝
        switch (model.type.intValue) {
            case 1:
                self.typeImageView.image = [UIImage imageNamed:@"txzh_icon_bank"];
                break;
            case 2:
                self.typeImageView.image = [UIImage imageNamed:@"txzh_icon_wechat"];
                break;
            case 3:
                self.typeImageView.image = [UIImage imageNamed:@"txzh_icon_alipay"];
                break;
            default:
                break;
        }
    };
    [self.navigationController pushViewController:choiceVc animated:YES];
}

#pragma mark - 网络
-(void)requestRatio{
    //获取手续费比例
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [params setJsonValue:@"ExtractFee" key:@"name"];
    [self showLoading];
    [[JMRequestManager sharedManager] POST:kUrlWithdrawRatio parameters:params completion:^(JMBaseResponse *response) {
        [self dismissLoading];
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            self.feeRatio = [response.responseObject getJsonValue:@"data"].integerValue;
            JMLoginUserModel *loginUser = [JMProjectManager sharedJMProjectManager].loginUser;
            self.maxMoney = loginUser.withdrawBlance.doubleValue / (1.0+self.feeRatio/100.0);
            self.moneyTextField.placeholder = [NSString stringWithFormat:@"可提现金额%.2f元",self.maxMoney];
        }
    }];
}

-(void)requestWithdraw{
    //提现
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [params setJsonValue:self.moneyTextField.text key:@"amount"];
    [params setJsonValue:self.selectAccountId key:@"extractAccountId"];
    
    [self showLoading];
    [[JMRequestManager sharedManager] POST:kUrlWithdraw parameters:params completion:^(JMBaseResponse *response) {
        [self dismissLoading];
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
            [self goSuccessVC];
        }
    }];
}
@end
