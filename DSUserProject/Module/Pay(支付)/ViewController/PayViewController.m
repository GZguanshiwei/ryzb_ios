//
//  PayViewController.m
//  JMBaseProject
//
//  Created by Liuny on 2019/1/5.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "PayViewController.h"
#import "PaySuccessViewController.h"
#import "PayFailViewController.h"
#import "JMThirdPayHelper.h"
#import "PayTransferSuccessViewController.h"
#import "PayPasswordAlterView.h"
#import "UCChangePasswordViewController.h"
#import "PayManyTimesViewController.h"

@interface PayViewController ()
@property (weak, nonatomic) IBOutlet UILabel *showOrderNoLabel;
@property (weak, nonatomic) IBOutlet UILabel *showMoneyLabel;

@property (weak, nonatomic) IBOutlet UIButton *wxSelectButton;
@property (weak, nonatomic) IBOutlet UIButton *zfbSelectButton;
@property (strong, nonatomic) IBOutlet UIButton *balanceSelectButton;
@property (weak, nonatomic) IBOutlet UIButton *partZfSelectButton;

@property (weak, nonatomic) IBOutlet UIButton *yuZfSelectButton;

@end

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)initControl{
    self.title = @"支付订单";
    self.showMoneyLabel.text = [NSString stringWithFormat:@"￥%.2f",self.totalPrice];
}

-(void)initData{
    self.wxSelectButton.selected = YES;
    self.showOrderNoLabel.text = self.orderNo;
}

#pragma mark - Actions
- (IBAction)payTypeAction:(id)sender {
    //支付方式
    UIButton *button = (UIButton *)sender;
    switch (button.tag) {
        case 0:
            self.balanceSelectButton.selected = NO;
            self.wxSelectButton.selected = YES;
            self.zfbSelectButton.selected = NO;
            self.partZfSelectButton.selected = NO;
            self.yuZfSelectButton.selected = NO;
            break;
        case 1:
            self.balanceSelectButton.selected = NO;
            self.wxSelectButton.selected = NO;
            self.zfbSelectButton.selected = YES;
            self.partZfSelectButton.selected = NO;
            self.yuZfSelectButton.selected = NO;
            break;
        case 2:
            self.balanceSelectButton.selected = YES;
            self.wxSelectButton.selected = NO;
            self.zfbSelectButton.selected = NO;
            self.partZfSelectButton.selected = NO;
            self.yuZfSelectButton.selected = NO;
            break;
        case 3:
            self.balanceSelectButton.selected = NO;
            self.wxSelectButton.selected = NO;
            self.zfbSelectButton.selected = NO;
            self.partZfSelectButton.selected = YES;
            self.yuZfSelectButton.selected = NO;
            break;
        case 4:
            self.balanceSelectButton.selected = NO;
            self.wxSelectButton.selected = NO;
            self.zfbSelectButton.selected = NO;
            self.partZfSelectButton.selected = NO;
            self.yuZfSelectButton.selected = YES;
            break;
        default:
            break;
    }
}

- (IBAction)payAction:(id)sender {
    //支付
    if(self.balanceSelectButton.isSelected){
        //银行转账
        [self requestBankTransferPay];
    }else if(self.yuZfSelectButton.selected){
        //余额支付
        [self checkHasPayPassword];
    }else if(self.partZfSelectButton.selected){
        //分次支付
        [self requestManyTimesPay];
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
    [[JMRequestManager sharedManager] POST:kUrlPay parameters:params completion:^(JMBaseResponse *response) {
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
            if(self.totalPrice > 0){
                NSString *payInfo = response.responseObject[@"data"];
                [[JMThirdPayHelper sharedJMThirdPayHelper] paymentWithData:payInfo type:type completionBlock:^(BOOL success) {
                    if(success){
                        if (self.inGroup) {
                            //支付成功
                            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationOrderPaySuccess object:nil];
                        }
                        [self goSuccessVC];
                    }else{
                        [self cancleOrderPlayer];
                    }
                }];
            }else{
                [self goSuccessVC];
            }
        }
    }];
}

-(void)requestBalancePay:(NSString *)password{
    //余额支付
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [params setJsonValue:self.orderNo key:@"orderNo"];
    [params setJsonValue:@"2" key:@"payType"];
    [params setJsonValue:password key:@"payPsw"];
    [[JMRequestManager sharedManager] POST:kUrlPay parameters:params completion:^(JMBaseResponse *response) {
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
             [self cancleOrderPlayer];
        }else{
            [JMProgressHelper toastInWindowWithMessage:@"支付成功"];
            if (self.inGroup) {
                //支付成功
                [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationOrderPaySuccess object:nil];
            }
            [self goSuccessVC];
        }
    }];
}

-(void)requestBankTransferPay{
    //银行转账
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [params setJsonValue:self.orderNo key:@"orderNo"];
    [params setJsonValue:@"4" key:@"payType"];
    [[JMRequestManager sharedManager] POST:kUrlPay parameters:params completion:^(JMBaseResponse *response) {
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
            [self cancleOrderPlayer];
        }else{
            [JMProgressHelper toastInWindowWithMessage:@"支付成功"];
            if (self.inGroup) {
                //支付成功
                [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationOrderPaySuccess object:nil];
            }
            if(self.totalPrice > 0){
                PayTransferSuccessViewController *successVC = [[PayTransferSuccessViewController alloc] initWithStoryboardName:@"Pay"];
                successVC.totalPrice = self.totalPrice;
                [self.navigationController pushViewController:successVC animated:YES];
            }else{
                [self goSuccessVC];
            }
        }
    }];
}



-(void)requestManyTimesPay{
    //分次支付
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [params setJsonValue:self.orderId key:@"orderId"];
    [[JMRequestManager sharedManager] POST:kUrlPayManyTimeCreate parameters:params completion:^(JMBaseResponse *response) {
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
            [self cancleOrderPlayer];
        }else{
            if(self.totalPrice > 0){
                NSDictionary *dataDic = response.responseObject[@"data"];
                PayManyTimesViewController *payManyVC = [[PayManyTimesViewController alloc] initWithStoryboardName:@"Pay"];
                payManyVC.orderNo = [dataDic getJsonValue:@"orderNo"];
                payManyVC.orderId = self.orderId;
                [self.navigationController pushViewController:payManyVC animated:YES];
            }else{
                [self goSuccessVC];
            }
        }
    }];
}

#pragma mark - 取消订单
-(void)cancleOrderPlayer
{
    NSMutableDictionary *parames = [JMCommonMethod baseRequestParams];
    [parames setValue:self.orderNo forKey:@"orderNo"];
    [[JMRequestManager sharedManager] POST:kUrlCancelPay parameters:parames completion:^(JMBaseResponse *response) {
        if (!response.error) {
            [self goFailVC];
        }
    }];
    
    
}
@end
