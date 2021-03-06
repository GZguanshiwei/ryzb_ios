//
//  BindPhoneViewController.m
//  JMBaseProject
//
//  Created by Liuny on 2018/11/7.
//  Copyright © 2018 liuny. All rights reserved.
//

#import "BindPhoneViewController.h"

@interface BindPhoneViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneCodeTextField;
@property (weak, nonatomic) IBOutlet UIButton *phoneCodeButton;
@property (weak, nonatomic) IBOutlet UIButton *commitButton;
@property (strong, nonatomic) JMPhoneCodeTool *phoneCodeTool;
@end

@implementation BindPhoneViewController

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
    self.title = @"绑定手机号";
}

-(void)initData{
    
}

-(JMPhoneCodeTool *)phoneCodeTool{
    if(_phoneCodeTool == nil){
        //此处的字典用于标识验证法发送的类型
        _phoneCodeTool = [[JMPhoneCodeTool alloc] initWithPhoneCodeButton:self.phoneCodeButton requestParams:@{@"type":@"Binding"}];
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
- (IBAction)sendPhoneCodeAction:(id)sender {
    //发送验证码
    [self.view endEditing:YES];
    self.phoneCodeTool.phoneNum = self.phoneTextField.text;
    //如果是国际号码，需要设置区号
//    self.phoneCodeTool.areaId = @""
    [self.phoneCodeTool sendPhoneCode];
}

- (IBAction)bindAction:(id)sender {
    //绑定
    NSString *phone = self.phoneTextField.text;
    if(JMIsEmpty(phone)){
        [JMProgressHelper toastInWindowWithMessage:self.phoneTextField.placeholder];
        return;
    }
    NSString *code = self.phoneCodeTextField.text;
    if(JMIsEmpty(code)){
        [JMProgressHelper toastInWindowWithMessage:self.phoneCodeTextField.placeholder];
        return;
    }
    [self requestBindPhone];
}

#pragma mark - 网络
-(void)requestBindPhone{
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [params setJsonValue:self.phoneTextField.text key:@"mobile"];
    [params setJsonValue:self.phoneCodeTextField.text key:@"code"];
    [params setJsonValue:@"0" key:@"registerType"];
    [params setJsonValue:self.ids key:@"ids"];
    [params setJsonValue:self.typeStr key:@"type"];
    
    [[JMRequestManager sharedManager] POST:kUrlThirdLoginBindPhone parameters:params completion:^(JMBaseResponse *response) {
        if (self.completeBlock) {
            self.completeBlock(response);
        }
    }];
}

@end
