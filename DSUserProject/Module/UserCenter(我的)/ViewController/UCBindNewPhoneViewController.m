//
//  UCBindNewPhoneViewController.m
//  JMBaseProject
//
//  Created by Liuny on 2019/6/26.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "UCBindNewPhoneViewController.h"

@interface UCBindNewPhoneViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneCodeTextField;
@property (weak, nonatomic) IBOutlet UIButton *phoneCodeButton;
@property (weak, nonatomic) IBOutlet UIButton *commitButton;

@property (strong, nonatomic) JMPhoneCodeTool *phoneCodeTool;
@end

@implementation UCBindNewPhoneViewController

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
    self.phoneCodeTool.phoneNum = self.phoneTextField.text;
    //如果是国际号码，需要设置区号
    //    self.phoneCodeTool.areaId = @""
    [self.phoneCodeTool sendPhoneCode];
    
}

- (IBAction)commitAction:(id)sender {
    [self requestBindNewPhone];
}

#pragma mark - 网络
-(void)requestBindNewPhone{
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [params setJsonValue:self.phoneTextField.text key:@"mobile"];
    [params setJsonValue:self.phoneCodeTextField.text key:@"code"];
    [params setJsonValue:@"0" key:@"registerType"];
    
    [[JMRequestManager sharedManager] POST:kUrlChangePhone parameters:params completion:^(JMBaseResponse *response) {
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
            [JMProgressHelper toastInWindowWithMessage:@"绑定新手机号成功"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }];
}
@end
