//
//  PayPasswordAlterView.m
//  JMBaseProject
//
//  Created by 抽筋的灯 on 2019/2/28.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "PayPasswordAlterView.h"

@interface PayPasswordAlterView()<UITextFieldDelegate>

/** 密码输入框view */
@property (weak, nonatomic) IBOutlet CustomPasswordView *passWordView;
/** 标题label */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/** 备注label */
@property (weak, nonatomic) IBOutlet UILabel *remarkLabel;
/** 金额label */
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;

@end

@implementation PayPasswordAlterView
- (void)awakeFromNib
{
    [super awakeFromNib];
}
- (void)initControl{
    [super initControl];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationTextChange:) name:UITextFieldTextDidChangeNotification object:self.passWordView.passwordTextField];
}

- (void)notificationTextChange:(NSNotification *)notification{
    if (self.passWordView.passwordTextField.text.length == 6) {
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [params setJsonValue:self.passWordView.passwordTextField.text key:@"passWord"];
        self.buttonClickBlock(params);
        [self hideView];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return true;
}

/**
 取消按钮点击事件
 */
- (IBAction)cancelButtonAction:(id)sender {
    [self hideView];
}

#pragma mark - 赋值
- (void)setAlterTitle:(NSString *)alterTitle{
    _alterTitle = alterTitle;
    self.titleLabel.text = alterTitle;
}

- (void)setAlterRemark:(NSString *)alterRemark{
    _alterRemark = alterRemark;
    self.remarkLabel.text = alterRemark;
}

- (void)setAlterAmount:(NSString *)alterAmount{
    _alterAmount = alterAmount;
    self.amountLabel.text = alterAmount;
}


@end
