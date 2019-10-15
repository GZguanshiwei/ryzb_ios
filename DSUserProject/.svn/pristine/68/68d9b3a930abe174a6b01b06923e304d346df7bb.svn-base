//
//  UCCheckOldPhoneViewController.m
//  JMBaseProject
//
//  Created by Liuny on 2019/6/26.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "UCCheckOldPhoneViewController.h"
#import "UCBindNewPhoneViewController.h"

@interface UCCheckOldPhoneViewController ()
@property (weak, nonatomic) IBOutlet UILabel *showPhoneLabel;
@property (weak, nonatomic) IBOutlet UITextField *phoneCodeTextField;
@property (weak, nonatomic) IBOutlet UIButton *phoneCodeButton;
@property (weak, nonatomic) IBOutlet UIButton *commitButton;

@property (strong, nonatomic) JMPhoneCodeTool *phoneCodeTool;
@end

@implementation UCCheckOldPhoneViewController

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
    JMLoginUserModel *loginUser = [JMProjectManager sharedJMProjectManager].loginUser;
    self.showPhoneLabel.text = loginUser.mobile;
}

-(JMPhoneCodeTool *)phoneCodeTool{
    if(_phoneCodeTool == nil){
        //此处的字典用于标识验证法发送的类型
        _phoneCodeTool = [[JMPhoneCodeTool alloc] initWithPhoneCodeButton:self.phoneCodeButton requestParams:@{@"type":@"Replace"}];
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
    JMLoginUserModel *loginUser = [JMProjectManager sharedJMProjectManager].loginUser;
    self.phoneCodeTool.phoneNum = loginUser.mobile;
    //如果是国际号码，需要设置区号
    //    self.phoneCodeTool.areaId = @""
    [self.phoneCodeTool sendPhoneCode];
    
}

- (IBAction)commitAction:(id)sender {
    NSString *code = self.phoneCodeTextField.text;
    if(code.length == 0){
        [JMProgressHelper toastInWindowWithMessage:@"请输入验证码"];
        return;
    }
    [self requestCheckPhoneCode];
}

#pragma mark - 网络
-(void)requestCheckPhoneCode{
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [params setJsonValue:self.phoneCodeTextField.text key:@"code"];
    JMLoginUserModel *loginUser = [JMProjectManager sharedJMProjectManager].loginUser;
    [params setJsonValue:loginUser.mobile key:@"mobile"];
    [params setJsonValue:@"0" key:@"registerType"];
    
    [[JMRequestManager sharedManager] POST:kUrlCheckCode parameters:params completion:^(JMBaseResponse *response) {
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
            UCBindNewPhoneViewController *bindNewPhoneVC = [[UCBindNewPhoneViewController alloc] initWithStoryboardName:@"UserCenter"];
            [self.navigationController pushViewController:bindNewPhoneVC animated:YES];
        }
    }];
}

@end
