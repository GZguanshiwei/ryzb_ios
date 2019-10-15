//
//  RefundViewController.m
//  JMBaseProject
//
//  Created by Liuny on 2019/6/27.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "RefundViewController.h"

@interface RefundViewController ()
@property (weak, nonatomic) IBOutlet UITextView *reasonTextView;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *freightLabel;

@end

@implementation RefundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)initControl{
    
}

-(void)initData{
    self.title = @"申请退款";
    
    self.moneyLabel.text = [NSString stringWithFormat:@"￥%@",self.order.totalPay];
}

#pragma mark - Actions
- (IBAction)commitAction:(id)sender {
    NSString *reason = self.reasonTextView.text;
    if(reason.length == 0){
        [JMProgressHelper toastInWindowWithMessage:self.reasonTextView.placeholder];
        return;
    }
    [self requestCommit];
}

#pragma mark - 网络
-(void)requestCommit{
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [params setJsonValue:self.order.orderId key:@"orderId"];
    [params setJsonValue:self.reasonTextView.text key:@"reason"];
    [[JMRequestManager sharedManager] POST:kUrlRefundOrder parameters:params completion:^(JMBaseResponse *response) {
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
            [JMProgressHelper toastInWindowWithMessage:response.responseObject[@"desc"]];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}
@end
