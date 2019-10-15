//
//  FeedbackViewController.m
//  JMBaseProject
//
//  Created by Liuny on 2019/6/25.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "FeedbackViewController.h"

@interface FeedbackViewController ()
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UITextView *contactTextView;

@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)initControl{
    
}

-(void)initData{
    self.title = @"意见反馈";
}

#pragma mark - Actions

- (IBAction)commitAction:(id)sender {
    if(self.contactTextView.text.length == 0){
        [JMProgressHelper toastInWindowWithMessage:self.contactTextView.placeholder];
        return;
    }
    [self requestFeedback];
}

-(void)commitSuccess{
    ScreenCenterTipView *tipView = [[ScreenCenterTipView alloc] initWithXib];
    tipView.message = @"感谢您的反馈和宝贵意见，我们会再接再厉，为您提供更优质的服务！";
    tipView.buttonTitles = @[@"确定"];
    [tipView showViewWithDoneBlock:^(NSDictionary * _Nonnull params) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

#pragma mark - 网络
-(void)requestFeedback{
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [params setJsonValue:self.contentTextView.text key:@"content"];
    [params setJsonValue:self.contactTextView.text key:@"contact"];
    [self showLoading];
    [[JMRequestManager sharedManager] POST:kUrlFeedback parameters:params completion:^(JMBaseResponse *response) {
        [self dismissLoading];
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
            [self commitSuccess];
        }
    }];
}
@end
