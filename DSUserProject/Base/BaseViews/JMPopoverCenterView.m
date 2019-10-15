//
//  JMPopoverCenterView.m
//  JMBaseProject
//
//  Created by Liuny on 2018/11/9.
//  Copyright © 2018 liuny. All rights reserved.
//

#import "JMPopoverCenterView.h"

@implementation JMPopoverCenterView

-(instancetype)initWithXib{
    NSArray *nibView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];
    self = nibView.firstObject;
    if(self){
        [self initControl];
        
    }
    return self;
}

-(void)showViewWithDoneBlock:(void(^)(NSDictionary *params))buttonClickBlock{
    if(buttonClickBlock){
        self.buttonClickBlock = buttonClickBlock;
    }
    [self initData];
    [self showView];
}

-(void)initControl{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        [self hideView];
    }];
    [self.bgView addGestureRecognizer:tapGesture];
    self.backgroundColor = [UIColor clearColor];
}

-(void)initData{
    
}

-(void)showView{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(window);
    }];
}

-(void)hideView{
    [self removeFromSuperview];
}
@end
