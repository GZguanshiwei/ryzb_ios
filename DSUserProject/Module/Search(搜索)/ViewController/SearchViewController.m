//
//  SearchViewController.m
//  JMBaseProject
//
//  Created by Liuny on 2019/7/2.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchDefaultViewController.h"
#import "SearchPageViewController.h"

@interface SearchViewController ()
@property (weak, nonatomic) IBOutlet UIView *unreadNumView;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UILabel *unreadNumLabel;

@property (nonatomic, strong) SearchPageViewController *resultVC;
@property (nonatomic, strong) SearchDefaultViewController *defaultVC;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"Result"]){
        self.resultVC = (SearchPageViewController *)segue.destinationViewController;
    }else if([segue.identifier isEqualToString:@"Default"]){
        self.defaultVC = (SearchDefaultViewController *)segue.destinationViewController;
        JMWeak(self);
        self.defaultVC.selectBlock = ^(NSString * _Nonnull searchKey) {
            weakself.searchTextField.text = searchKey;
            [weakself showDefaultView:NO];
        };
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //获取系统消息未读数
    [self requsetUnReadCount];
}

-(void)initControl{
    self.unreadNumView.layer.cornerRadius = self.unreadNumView.mj_h/2.0;
    [self showDefaultView:YES];
    
    self.searchTextField.delegate = self;
    [self.searchTextField becomeFirstResponder];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requsetUnReadCount) name:kNotificationSystemNotice object:nil];
}

-(void)initData{
    [self requsetUnReadCount];
}

-(void)showDefaultView:(BOOL)isShow{
    if(isShow){
        [self.view bringSubviewToFront:self.defaultVC.view.superview];
    }else{
        [self.view bringSubviewToFront:self.resultVC.view.superview];
        self.resultVC.searchKey = self.searchTextField.text;
    }
}

#pragma mark - Navigation
-(BOOL)navUIBaseViewControllerIsNeedNavBar:(JMNavUIBaseViewController *)navUIBaseViewController{
    return NO;
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
}

-(UIReturnKeyType)textViewControllerLastReturnKeyType:(JMTextViewController *)textViewController{
    return UIReturnKeySearch;
}

- (IBAction)messageAction:(id)sender {
    NewsViewController *newsVC = [[NewsViewController alloc] initWithStoryboardName:@"News"];
    [self.navigationController pushViewController:newsVC animated:YES];
}

#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [super textFieldShouldReturn:textField];
    [self showDefaultView:NO];
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    [super textField:textField shouldChangeCharactersInRange:range replacementString:string];
    NSString *new = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if(new.length == 0){
        [self showDefaultView:YES];
    }
    return YES;
}

/**
 获取系统消息未读数
 */
- (void)requsetUnReadCount {
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [[JMRequestManager sharedManager] POST:kUrlUnReadCount parameters:params completion:^(JMBaseResponse *response) {
        if (response.error) {
            
        }else {
            NSString *num = [response.responseObject getJsonValue:@"data"];
            if (num.integerValue == 0) {
                self.unreadNumView.hidden = YES;
            }else {
                self.unreadNumView.hidden = NO;
                self.unreadNumLabel.text = num;
            }
        }
    }];
}

@end
