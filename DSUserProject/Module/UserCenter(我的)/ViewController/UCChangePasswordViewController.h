//
//  UCChangePasswordViewController.h
//  JMBaseProject
//
//  Created by Liuny on 2019/6/25.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "JMBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, UCChangePasswordViewControllerType) {
    UCChangePasswordViewControllerTypeLogin, //修改登录密码
    UCChangePasswordViewControllerTypePay //修改支付密码
};
@interface UCChangePasswordViewController : JMBaseViewController
@property(nonatomic,assign)UCChangePasswordViewControllerType type;
@end

NS_ASSUME_NONNULL_END
