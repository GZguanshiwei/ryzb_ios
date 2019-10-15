//
//  PayManyTimesViewController.m
//  JMBaseProject
//
//  Created by Liuny on 2019/9/17.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "PayManyTimesViewController.h"
#import "PayPasswordAlterView.h"
#import "UCChangePasswordViewController.h"
#import "PayManyTimesViewController.h"
#import "PaySuccessViewController.h"
#import "PayFailViewController.h"
#import "JMThirdPayHelper.h"

@interface PayManyTimesViewController ()
@property (weak, nonatomic) IBOutlet UILabel *showMoneyLabel;
@property (weak, nonatomic) IBOutlet UITextField *inputMoneyTF;

@property (weak, nonatomic) IBOutlet UIButton *wxSelectButton;
@property (weak, nonatomic) IBOutlet UIButton *zfbSelectButton;
@property (weak, nonatomic) IBOutlet UIButton *yuZfSelectButton;
@end

@implementation PayManyTimesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)initControl{
    self.title = @"支付订单";
}

-(void)initData{
    self.wxSelectButton.selected = YES;
    [self requestManyPayMoney];
}

#pragma mark - Actions
- (IBAction)payTypeAction:(id)sender {
    //支付方式
    self.wxSelectButton.selected = NO;
    self.zfbSelectButton.selected = NO;
    self.yuZfSelectButton.selected = NO;
    UIButton *button = (UIButton *)sender;
    switch (button.tag) {
        case 0:
            self.wxSelectButton.selected = YES;
            break;
        case 1:
            self.zfbSelectButton.selected = YES;
            break;
        case 4:
            self.yuZfSelectButton.selected = YES;
            break;
        default:
            break;
    }
}

- (IBAction)payAction:(id)sender {
    //支付
    
    NSString *inputMoney = self.inputMoneyTF.text;
    if(inputMoney.doubleValue <= 0){
        [JMProgressHelper toastInWindowWithMessage:@"请输入正确的金额"];
        return;
    }
    
    if(self.yuZfSelectButton.selected){
        //余额支付
        [self checkHasPayPassword];
    }else {
        [self requestPay];
    }
}

#pragma mark - 输入支付密码
-(void)inputPayPassword{
    PayPasswordAlterView *payView = [[PayPasswordAlterView alloc] initWithXib];
    [payView showViewWithDoneBlock:^(NSDictionary * _Nonnull params) {
        NSString *password = [params getJsonValue:@"passWord"];
        [self requestBalancePay:password];
    }];
}

-(void)checkHasPayPassword{
    JMLoginUserModel *loginUser = [JMProjectManager sharedJMProjectManager].loginUser;
    if(loginUser.hasPayPassword){
        [self inputPayPassword];
    }else{
        UCChangePasswordViewController *passwordSetVC = [[UCChangePasswordViewController alloc] initWithStoryboardName:@"UserCenter"];
        passwordSetVC.type = UCChangePasswordViewControllerTypePay;
        [self.navigationController pushViewController:passwordSetVC animated:YES];
    }
}

#pragma mark - 跳转
-(void)goSuccessVC{
    PaySuccessViewController *successVC = [[PaySuccessViewController alloc] initWithStoryboardName:@"Pay"];
    successVC.orderId = self.orderId;
    [self.navigationController pushViewController:successVC animated:YES];
}

-(void)goFailVC{
    PayFailViewController *failVC = [[PayFailViewController alloc] initWithStoryboardName:@"Pay"];
    [self.navigationController pushViewController:failVC animated:YES];
}

#pragma mark - 网络
-(void)requestPay{
    PaymentType type;
    NSString *requestType;
    if(self.wxSelectButton.isSelected){
        type = PaymentTypeWechat;
        requestType = @"1";
    }else{
        type = PaymentTypeAlipay;
        requestType = @"0";
    }
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [params setJsonValue:self.orderNo key:@"orderNo"];
    [params setJsonValue:requestType key:@"payType"];
    [params setJsonValue:self.inputMoneyTF.text key:@"payPrice"];
    [[JMRequestManager sharedManager] POST:kUrlManyPay parameters:params completion:^(JMBaseResponse *response) {
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
            NSString *payInfo = response.responseObject[@"data"];
            [[JMThirdPayHelper sharedJMThirdPayHelper] paymentWithData:payInfo type:type completionBlock:^(BOOL success) {
                if(success){
                    [self goSuccessVC];
                }else{
                    [self goFailVC];
                }
            }];
        }
    }];
}

-(void)requestBalancePay:(NSString *)password{
    //余额支付
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [params setJsonValue:self.orderNo key:@"orderNo"];
    [params setJsonValue:@"2" key:@"payType"];
    [params setJsonValue:password key:@"payPsw"];
    [params setJsonValue:self.inputMoneyTF.text key:@"payPrice"];
    [[JMRequestManager sharedManager] POST:kUrlManyPay parameters:params completion:^(JMBaseResponse *response) {
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
            [self goFailVC];
        }else{
            [JMProgressHelper toastInWindowWithMessage:@"支付成功"];
            [self goSuccessVC];
        }
    }];
}

-(void)requestManyPayMoney{
    //剩余应付金额
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [params setJsonValue:self.orderId key:@"orderId"];
    [[JMRequestManager sharedManager] POST:kUrlPayManyHasPay parameters:params completion:^(JMBaseResponse *response) {
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
            NSDictionary *dic = response.responseObject;
            NSString *money = [dic getJsonValue:@"data"];
            self.showMoneyLabel.text = [NSString stringWithFormat:@"￥%@",money];
        }
    }];
}
@end
