//
//  AddCashAccountView.m
//  JMBaseProject
//
//  Created by 潘传标 on 2019/9/7.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "AddCashAccountView.h"

@interface AddCashAccountView()

@property (weak, nonatomic) IBOutlet UIView *accountTypeView;

@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UITextField *bankNameField;
@property (weak, nonatomic) IBOutlet UITextField *accountFied;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UIView *bankNameInputView;
@property (weak, nonatomic) IBOutlet UIView *accountInputView;
@property (weak, nonatomic) IBOutlet UIView *nameInputView;

@end

@implementation AddCashAccountView

+(void)addCashAccountWithHandle:(void(^)(NSDictionary *dataDic))sureHandle
{
    AddCashAccountView *alertView =   [[self alloc] init];
    alertView.frame = [UIScreen mainScreen].bounds;
    [[UIApplication sharedApplication].keyWindow addSubview:alertView];
    alertView.confirmBlock = ^(NSDictionary *data) {
        if (sureHandle) {
            sureHandle(data);
        }
    };
}

//选择账户类型

- (IBAction)selectButtonClick:(id)sender {
    self.accountTypeView.hidden = NO;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"AddCashAccountView" owner:nil options:nil] lastObject];
    }
    return self;
}

- (IBAction)typeButtonClick:(UIButton *)sender {
    switch (sender.tag) {
        case 0:
            self.nameLable.text = @"微信";
            self.nameInputView.hidden = YES;
            self.bankNameInputView.hidden = YES;
            self.accountFied.placeholder = @"请输入微信账号";
            break;
        case 1:
            self.nameLable.text = @"支付宝";
            self.nameInputView.hidden = NO;
            self.bankNameInputView.hidden = YES;
            self.accountFied.placeholder = @"请输入支付宝账号";
            self.nameField.placeholder = @"请输入支付宝账号姓名";
            break;
        case 2:
            self.nameLable.text = @"银行卡";
            self.nameInputView.hidden = NO;
            self.bankNameInputView.hidden = NO;
            self.bankNameField.placeholder = @"请输入银行名称";
            self.accountFied.placeholder = @"请输入银行卡账号";
            self.nameField.placeholder = @"请输入持卡人姓名";
            break;
            
        default:
            break;
    }
    self.accountTypeView.hidden = YES;
}

- (IBAction)sureButtonClick:(id)sender {
    NSString *type;
    //确定
    if ([self.nameLable.text isEqualToString:@"微信"]) {
        //微信
        type = @"2";
        if (self.accountFied.text.length == 0) {
            [JMProgressHelper toastInWindowWithMessage:self.accountFied.placeholder];
            return;
        }
    }else if ([self.nameLable.text isEqualToString:@"支付宝"]) {
        //支付宝
        type = @"3";
        if (self.accountFied.text.length == 0) {
            [JMProgressHelper toastInWindowWithMessage:self.accountFied.placeholder];
            return;
        }
        if (self.nameField.text.length == 0) {
            [JMProgressHelper toastInWindowWithMessage:self.nameField.placeholder];
            return;
        }
    }else {
        //银行卡
        type = @"1";
        if (self.accountFied.text.length == 0) {
            [JMProgressHelper toastInWindowWithMessage:self.accountFied.placeholder];
            return;
        }
        if (self.nameField.text.length == 0) {
            [JMProgressHelper toastInWindowWithMessage:self.nameField.placeholder];
            return;
        }
        if (self.bankNameField.text.length == 0) {
            [JMProgressHelper toastInWindowWithMessage:self.bankNameField.placeholder];
            return;
        }
    }
    
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    [dataDic setValue:type forKey:@"type"];
    [dataDic setValue:self.accountFied.text forKey:@"account"];
    [dataDic setValue:self.bankNameField.text forKey:@"bankName"];
    [dataDic setValue:self.nameField.text forKey:@"name"];
    if (self.confirmBlock) {
        self.confirmBlock(dataDic.copy);
    }
    [self removeFromSuperview];
}

- (IBAction)cancelButtonClick:(id)sender {
    //取消
    [self removeFromSuperview];
}

@end
