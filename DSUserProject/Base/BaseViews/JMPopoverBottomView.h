//
//  JMPopoverBottomView.h
//  JMBaseProject
//
//  Created by liuny on 2018/7/17.
//  Copyright © 2018年 liuny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JMPopoverBottomView : UIView
//用于参数传递
@property (nonatomic, copy) void(^buttonClickBlock)(NSDictionary *params);

@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;
@property (strong, nonatomic) IBOutlet UIView *mainView;

//初始化
-(instancetype)initWithXib;
-(void)initControl;
-(void)initData;
//显示
-(void)showViewWithDoneBlock:(void(^)(NSDictionary *params))buttonClickBlock;
//消失
-(void)hideWithAnmation:(BOOL)flag;
@end
