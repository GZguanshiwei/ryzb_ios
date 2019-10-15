//
//  JMPopoverCenterView.h
//  JMBaseProject
//
//  Created by Liuny on 2018/11/9.
//  Copyright © 2018 liuny. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JMPopoverCenterView : UIView
//用于参数传递
@property (nonatomic, copy) void(^buttonClickBlock)(NSDictionary *params);

@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (strong, nonatomic) IBOutlet UIView *mainView;

//初始化
-(instancetype)initWithXib;
-(void)initControl;
-(void)initData;
//显示
-(void)showViewWithDoneBlock:(void(^)(NSDictionary *params))buttonClickBlock;
//消失
-(void)hideView;
@end

NS_ASSUME_NONNULL_END
