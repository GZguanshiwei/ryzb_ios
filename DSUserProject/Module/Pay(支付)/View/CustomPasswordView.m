//
//  CustomPasswordView.m
//  JMBaseProject
//
//  Created by 抽筋的灯 on 2019/3/1.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "CustomPasswordView.h"


//小黑点Size
#define kDotSize CGSizeMake (11.0f,11.0f)

//间隔宽
#define kPasswordSpace 0

//密码长度
#define kPasswordCount 6

@interface CustomPasswordView ()<UITextFieldDelegate>

@end

@implementation CustomPasswordView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // 监听textfield输入，对应显示小黑点
        [[NSNotificationCenter defaultCenter] addObserverForName:UITextFieldTextDidChangeNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note){
            
            if ([note.object isEqual:self.passwordTextField])
            {
                [self setDotWithCount:self.passwordTextField.text.length];
            }
        }];
        
        [self initView];
        [self fieldBecomeFirstResponder];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        // 监听textfield输入，对应显示小黑点
        [[NSNotificationCenter defaultCenter] addObserverForName:UITextFieldTextDidChangeNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note){
            
            if ([note.object isEqual:self.passwordTextField])
            {
                [self setDotWithCount:self.passwordTextField.text.length];
            }
        }];
        
        [self initView];
        [self fieldBecomeFirstResponder];
    }
    
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

/**
 弹出键盘并清除textfield内容
 */
-(void)fieldBecomeFirstResponder
{
    [self clearUpPassword];
    [self.passwordTextField becomeFirstResponder];
}

- (void)initView
{
    // 添加点击事件
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(fieldBecomeFirstResponder)]];
    
    self.backgroundColor = [UIColor clearColor];
    
    self.passwordIndicatorArrary = [[NSMutableArray alloc] init];
    
    self.passwordTextField = [[UITextField alloc] init];
    self.passwordTextField.hidden = YES;
    self.passwordTextField.delegate = self;
    self.passwordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.passwordTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self addSubview:self.passwordTextField];
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    

    UIStackView *stackView = [[UIStackView alloc] init];
    [self addSubview:stackView];
    [stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    //间距
    stackView.spacing = kPasswordSpace;
    
    UIView *leftItem;
    for(int i=0;i<kPasswordCount;i++){
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor clearColor];
        if (i != kPasswordCount - 1) {
            UIView *lineView = [[UIView alloc] init];
            lineView.backgroundColor = [UIColor colorWithHexString:@"#DADADA"];
            [view addSubview:lineView];
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.right.bottom.mas_offset(0);
                make.width.mas_offset(1);
            }];
        }
 
//        //边框
//        ViewBorderRadius(view, 0, 0.5, [UIColor colorWithHexString:@"#DADADA"]);
        //小黑点
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.backgroundColor = [UIColor blackColor];
        ViewRadius(imageView, kDotSize.width / 2.0);
        [view addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(kDotSize);
            make.center.equalTo(view);
        }];
        //保存
        [self.passwordIndicatorArrary addObject:imageView];
        
        [stackView addArrangedSubview:view];
        if(leftItem){
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(leftItem);
            }];
        }else{
            leftItem = view;
        }
    }
    
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = [UIColor colorWithHexString:@"#DADADA"].CGColor;
    self.layer.borderWidth = 1;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if([string isEqualToString:@"\n"]){
        //按回车关闭键盘
        [textField resignFirstResponder];
        return NO;
    }else if(string.length == 0){
        //判断是不是删除键
        return YES;
    }else if(textField.text.length >= kPasswordCount){
        //输入的字符个数大于6，则无法继续输入，返回NO表示禁止输入
        return NO;
    }else{
        return YES;
    }
}

/**
 设置小黑点显示

 @param count textfield的密码位数
 */
- (void)setDotWithCount:(NSInteger)count
{
    for (UIImageView *dotImageView in self.passwordIndicatorArrary)
    {
        dotImageView.hidden = YES;
    }
    
    for (int i = 0; i< count; i++)
    {
        ((UIImageView*)[self.passwordIndicatorArrary objectAtIndex:i]).hidden = NO;
    }
}

/**
 清除密码
 */
- (void)clearUpPassword
{
    self.passwordTextField.text = @"";
    [self setDotWithCount:_passwordTextField.text.length];
}


/**
 点击弹出键盘
 */
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.passwordTextField becomeFirstResponder];
}

@end
