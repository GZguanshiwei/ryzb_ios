//
//  PhoneLoginViewController.m
//  JMBaseProject
//
//  Created by Liuny on 2019/6/15.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "PhoneLoginViewController.h"

@interface PhoneLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneCodeTF;
@property (weak, nonatomic) IBOutlet UIButton *sendCodeButton;
@property (strong, nonatomic) JMPhoneCodeTool *phoneCodeTool;
@end

@implementation PhoneLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)initControl{
    self.view.backgroundColor = [UIColor whiteColor];
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.phoneCodeTool stopTimer];
}


-(JMPhoneCodeTool *)phoneCodeTool{
    if(_phoneCodeTool == nil){
        //此处的字典用于标识验证法发送的类型
        _phoneCodeTool = [[JMPhoneCodeTool alloc] initWithPhoneCodeButton:self.sendCodeButton requestParams:@{@"type":@"Login"}];
    }
    return _phoneCodeTool;
}


#pragma mark - Actions
- (IBAction)sendPhoneCodeAction:(id)sender {
    //发送验证码
    [self.view endEditing:YES];
    self.phoneCodeTool.phoneNum = self.phoneTF.text;
    //如果是国际号码，需要设置区号
    //    self.phoneCodeTool.areaId = @""
    [self.phoneCodeTool sendPhoneCode];
}
- (IBAction)loginAction:(id)sender {
    //手机验证码登录
    NSString *phone = self.phoneTF.text;
    if (phone.length == 0) {
        [JMProgressHelper toastInWindowWithMessage:self.phoneTF.placeholder];
        return;
    }
    NSString *code = self.phoneCodeTF.text;
    if (code.length == 0) {
        [JMProgressHelper toastInWindowWithMessage:self.phoneCodeTF.placeholder];
        return;
    }
    
    [self requestNormalLogin];
}
- (IBAction)accountLoginAction:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark - 网络
-(void)requestNormalLogin{
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [params setJsonValue:self.phoneTF.text key:@"loginAccount"];
    [params setJsonValue:self.phoneCodeTF.text key:@"code"];
    [params setJsonValue:@"MobileCode" key:@"loginType"];
    [params setJsonValue:@"0" key:@"registerType"];
    [self showLoading];
    [[JMProjectManager sharedJMProjectManager] loginWithParams:params successBlock:^{
        //成功
        [self dismissLoading];
        [[JMProjectManager sharedJMProjectManager] showMainViewController];
    } failBlock:^(NSString *errorMsg) {
        //失败
        [self dismissLoading];
        [JMProgressHelper toastInWindowWithMessage:errorMsg];
    }];
}
@end