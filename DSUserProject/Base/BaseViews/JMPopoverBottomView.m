//
//  JMPopoverBottomView.m
//  JMBaseProject
//
//  Created by liuny on 2018/7/17.
//  Copyright © 2018年 liuny. All rights reserved.
//

#import "JMPopoverBottomView.h"

@implementation JMPopoverBottomView

-(instancetype)initWithXib{
    NSArray *nibView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];
    self = nibView.firstObject;
    if(self){
        [self initControl];
    }
    return self;
}

-(void)showViewWithDoneBlock:(void(^)(NSDictionary *params))buttonClickBlock{
    [self initData];
    if(buttonClickBlock){
        self.buttonClickBlock = buttonClickBlock;
    }
    [self showWithAnmation:YES];
}

-(void)initControl{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        [self hideWithAnmation:YES];
    }];
    [self.bgView addGestureRecognizer:tapGesture];
    self.backgroundColor = [UIColor clearColor];
}

-(void)initData{
    
}

-(void)showWithAnmation:(BOOL)flag{
    self.bgView.alpha = 0;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(window);
    }];
    if(flag){
        //带动画
        self.bottomConstraint.constant = self.mainView.mj_h;
        [self updateConstraintsIfNeeded];
        [self layoutIfNeeded];
        
        self.bottomConstraint.constant = 0;
        [UIView animateWithDuration:0.3 animations:^{
            self.bgView.alpha = 0.5;
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
            
        }];
    }else{
        //不带动画
        self.bgView.alpha = 0.5;
    }
}


-(void)hideWithAnmation:(BOOL)flag{
    if(flag){
        //带动画
        self.bottomConstraint.constant = self.mainView.mj_h;
        [UIView animateWithDuration:0.3 animations:^{
            self.bgView.alpha = 0.0;
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }else{
        //不带动画
        [self removeFromSuperview];
    }
}

@end
