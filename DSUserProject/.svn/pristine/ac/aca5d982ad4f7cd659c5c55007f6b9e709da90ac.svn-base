//
//  MyCouponDetailController.m
//  JMBaseProject
//
//  Created by 潘传标 on 2019/9/7.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "BuyCouponDetailController.h"
#import "ChoiceAddressView.h"

@interface BuyCouponDetailController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *integralLabel;
@property (weak, nonatomic) IBOutlet UILabel *exchangeNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *explainLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;

@end

@implementation BuyCouponDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initControl
{
    self.jm_navgationBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
}


-(void)initData{
    self.integralLabel.text = [NSString stringWithFormat:@"%@积分",self.good.exchangeIntegral];
    self.nameLabel.text = self.good.name;
    self.exchangeNumLabel.text = [NSString stringWithFormat:@"已兑换%@",self.good.exchangeCount];
    [self.imageView sd_setImageWithURL:[JMCommonMethod imageUrlWithPath:self.good.coverImage]];
    [self requestCouponDetail];
}

#pragma mark - UINavigation
- (IBAction)backButtonClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Actions
- (IBAction)exchangeAction:(id)sender {
    [self requestExchangeCoupon];
}

#pragma mark - 网络
-(void)requestCouponDetail{
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [params setJsonValue:self.good.ids key:@"couponId"];
    [params setJsonValue:@"1" key:@"type"];
    [[JMRequestManager sharedManager] POST:kUrlCouponDetail parameters:params completion:^(JMBaseResponse *response) {
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
            NSDictionary *dataDic = response.responseObject[@"data"];
            self.tipLabel.text = [dataDic getJsonValue:@"tips"];
            self.endTimeLabel.text = [NSString stringWithFormat:@"%@天",[dataDic getJsonValue:@"overdueDay"]];
            NSString *type = [dataDic getJsonValue:@"type"];
            NSString *explainText;
            switch (type.integerValue) {
                case 0:
                    explainText = @"本优惠券仅限商城宝贝可用，直播间不可用";
                    break;
                case 1:
                {
                    NSString *roomName = [dataDic getJsonValue:@"roomName"];
                    explainText = [NSString stringWithFormat:@"本优惠券仅限%@直播间可用，商城不可用",roomName];
                    break;
                }
                case 2:
                    explainText = @"本优惠券为通用优惠券";
                    break;
                default:
                    break;
            }
            if(explainText){
                self.explainLabel.text = explainText;
            }
        }
    }];
}

-(void)requestExchangeCoupon{
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [params setJsonValue:self.good.goodId key:@"integralId"];
    [self showLoading];
    [[JMRequestManager sharedManager] POST:kUrlIntegralExchange parameters:params completion:^(JMBaseResponse *response) {
        [self dismissLoading];
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
            [JMProgressHelper toastInWindowWithMessage:@"兑换成功"];
        }
    }];
}
@end
