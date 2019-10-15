//
//  MyShopEditPhoneViewController.m
//  JMBaseProject
//
//  Created by Liuny on 2019/6/28.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "MyShopEditPhoneViewController.h"
#import "RegularExp.h"

@interface MyShopEditPhoneViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

@end

@implementation MyShopEditPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)initControl{
    self.title = @"联系电话";
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)initData{
    JMLoginUserModel *loginUser = [JMProjectManager sharedJMProjectManager].loginUser;
    self.phoneTextField.text = loginUser.shopMobile;
}

#pragma mark - Navigation
-(UIImage *)jmNavigationBarRightButtonImage:(UIButton *)rightButton navigationBar:(JMNavigationBar *)navigationBar{
    [JMCommonMethod navigationItemSet:rightButton fontColor:[UIColor whiteColor]];
    [rightButton setTitle:@"保存" forState:UIControlStateNormal];
    return nil;
}

-(void)rightButtonEvent:(UIButton *)sender navigationBar:(JMNavigationBar *)navigationBar{
    NSString *mobile = self.phoneTextField.text;
    BOOL isMoblie = [RegularExp isMobileGuoJi:mobile];
    if(isMoblie == NO){
        [JMProgressHelper toastInWindowWithMessage:@"手机号码格式错误"];
        return;
    }
    [self requestEditPhone:mobile];
}

#pragma mark - 网络
-(void)requestEditPhone:(NSString *)mobile{
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [params setJsonValue:mobile key:@"mobile"];
    [self showLoading];
    [[JMRequestManager sharedManager] POST:kUrlEditShopMobile parameters:params completion:^(JMBaseResponse *response) {
        [self dismissLoading];
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
            [JMProgressHelper toastInWindowWithMessage:response.responseObject[@"desc"]];
            JMLoginUserModel *loginUser = [JMProjectManager sharedJMProjectManager].loginUser;
            loginUser.shopMobile = mobile;
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}
@end
