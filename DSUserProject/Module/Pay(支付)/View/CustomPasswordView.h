//
//  CustomPasswordView.h
//  JMBaseProject
//
//  Created by 抽筋的灯 on 2019/3/1.
//  Copyright © 2019 liuny. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomPasswordView : UIView

/** 密码输入框 */
@property (nonatomic, strong) UITextField *passwordTextField;
/** 密码小黑点数组 */
@property (nonatomic, strong) NSMutableArray *passwordIndicatorArrary;

@end

NS_ASSUME_NONNULL_END
