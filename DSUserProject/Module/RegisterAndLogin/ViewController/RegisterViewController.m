//
//  RegisterViewController.m
//  JMBaseProject
//
//  Created by Liuny on 2018/11/7.
//  Copyright © 2018 liuny. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneCodeTextField;
@property (weak, nonatomic) IBOutlet UIButton *phoneCodeButton;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *commitButton;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField;

@property (strong, nonatomic) JMPhoneCodeTool *phoneCodeTool;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.phoneCodeTool stopTimer];
}

-(void)initControl{
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)initData{
    
}

-(JMPhoneCodeTool *)phoneCodeTool{
    if(_phoneCodeTool == nil){
        //此处的字典用于标识验证法发送的类型
        _phoneCodeTool = [[JMPhoneCodeTool alloc] initWithPhoneCodeButton:self.phoneCodeButton requestParams:@{@"type":@"Register"}];
    }
    return _phoneCodeTool;
}

#pragma mark - Navigation
-(UIImage *)jmNavigationBarLeftButtonImage:(UIButton *)leftButton navigationBar:(JMNavigationBar *)navigationBar{
    return [UIImage imageNamed:@"NavigationBack_Gray"];
}

-(UIColor *)jmNavigationBackgroundColor:(JMNavigationBar *)navigationBar{
    return [UIColor whiteColor];
}

- (NSArray <UIButton *> *)textViewControllerRelationButtons:(JMTextViewController *)textViewController{
    return @[self.commitButton];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

#pragma mark - Actions
- (IBAction)acceptInfoAction:(id)sender {
    //注册协议
    HtmlViewController *htmlVC = [[HtmlViewController alloc] init];
    htmlVC.type = Html_Register;
    [self.navigationController pushViewController:htmlVC animated:YES];
}

- (IBAction)sendPhoneCodeAction:(id)sender {
    //发送验证码
    [self.view endEditing:YES];
    self.phoneCodeTool.phoneNum = self.phoneTextField.text;
    //如果是国际号码，需要设置区号
    //    self.phoneCodeTool.areaId = @"";
    [self.phoneCodeTool sendPhoneCode];
}

- (IBAction)registerAction:(id)sender {
    //注册
    NSString *phone = self.phoneTextField.text;
    if(phone.length == 0){
        [JMProgressHelper toastInWindowWithMessage:self.phoneTextField.placeholder];
        return;
    }
    NSString *code = self.phoneCodeTextField.text;
    if(code.length == 0){
        [JMProgressHelper toastInWindowWithMessage:self.phoneCodeTextField.placeholder];
        return;
    }
    NSString *password = self.passwordTextField.text;
    if(password.length == 0){
        [JMProgressHelper toastInWindowWithMessage:self.passwordTextField.placeholder];
        return;
    }
    NSString *confirmPassword = self.confirmPasswordTextField.text;
    if([password isEqualToString:confirmPassword] == NO){
        [JMProgressHelper toastInWindowWithMessage:@"两次输入的密码不相同"];
        return;
    }
    [self requestRegister];
}

#pragma mark - 网络
-(void)requestRegister{
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [params setJsonValue:self.phoneTextField.text key:@"mobile"];
    [params setJsonValue:self.phoneCodeTextField.text key:@"code"];
    [params setJsonValue:self.passwordTextField.text key:@"password"];
    [params setJsonValue:@"0" key:@"registerType"];
    
    [self showLoading];
    [[JMRequestManager sharedManager] POST:kUrlRegister parameters:params completion:^(JMBaseResponse *response) {
        [self dismissLoading];
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
            [JMProgressHelper toastInWindowWithMessage:response.responseObject[@"desc"]];
            //跳回登录
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

@end
 
