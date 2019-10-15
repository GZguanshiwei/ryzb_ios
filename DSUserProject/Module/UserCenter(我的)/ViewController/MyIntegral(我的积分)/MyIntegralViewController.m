//
//  MyIntegralViewController.m
//  JMBaseProject
//
//  Created by 潘传标 on 2019/9/6.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "MyIntegralViewController.h"
#import "IntegralMallViewController.h"
@interface MyIntegralViewController ()
@property (weak, nonatomic) IBOutlet UILabel *integralLabel;

@end

@implementation MyIntegralViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initControl
{
    self.title = @"我的积分";
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestMyIntegral];
}

#pragma mark - UINavigation
-(UIColor *)jmNavigationBackgroundColor:(JMNavigationBar *)navigationBar{
    return [UIColor clearColor];
}

- (IBAction)selectButtonClcik:(id)sender {
    UIButton *button = (UIButton *)sender;
    switch (button.tag) {
        case 0:
            //积分兑换
        {
        IntegralMallViewController *mallVc = [[IntegralMallViewController alloc] initWithStoryboardName:@"Mine"];
         [self.navigationController pushViewController:mallVc animated:YES];
        }
            break;
        case 1:
            //积分规则
        {
            HtmlViewController *htmlVC = [[HtmlViewController alloc] init];
            htmlVC.type = Html_Integral;
            [self.navigationController pushViewController:htmlVC animated:YES];
            
        }
            
            break;
            
        default:
            break;
    }
}

#pragma mark - 网络
-(void)requestMyIntegral{
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [[JMRequestManager sharedManager] POST:kUrlMyInfo parameters:params completion:^(JMBaseResponse *response) {
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
            NSDictionary *dataDic = response.responseObject[@"data"];
            self.integralLabel.text = [dataDic getJsonValue:@"integral"];
            [JMProjectManager sharedJMProjectManager].loginUser.integral = [dataDic getJsonValue:@"integral"];
        }
    }];
}
@end
