//
//  PayTransferSuccessViewController.m
//  JMBaseProject
//
//  Created by Liuny on 2019/7/10.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "PayTransferSuccessViewController.h"

@interface PayTransferSuccessViewController ()
@property (weak, nonatomic) IBOutlet UILabel *showMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *bankNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ownerNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *accountNoLabel;

@end

@implementation PayTransferSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)initControl{
    
}

-(void)initData{
    self.title = @"银行转账";
    
    self.showMoneyLabel.text = [NSString stringWithFormat:@"￥%.2f",self.totalPrice];
    [self requestBankInfo];
}

#pragma mark - Navigation
-(void)leftButtonEvent:(UIButton *)sender navigationBar:(JMNavigationBar *)navigationBar{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - 网络
-(void)requestBankInfo{
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [[JMRequestManager sharedManager] POST:kUrlBankInfo parameters:params completion:^(JMBaseResponse *response) {
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
            NSDictionary *dataDic = response.responseObject[@"data"];
            NSDictionary *bankName = dataDic[@"openingBank"];
            NSDictionary *accountNo = dataDic[@"paymentAccount"];
            NSDictionary *accountName = dataDic[@"paymentName"];
            self.bankNameLabel.text = [bankName getJsonValue:@"content"];
            self.ownerNameLabel.text = [accountName getJsonValue:@"content"];
            self.accountNoLabel.text = [accountNo getJsonValue:@"content"];
        }
    }];
}
@end
