//
//  JMPhoneCodeTool.h
//  XPBiPro
//
//  Created by liuny on 2018/5/17.
//  Copyright © 2018年 liuny. All rights reserved.
//
/**
 发送验证码封装
 */
#import <Foundation/Foundation.h>
@interface JMPhoneCodeTool : NSObject
@property(nonatomic,strong) NSString *phoneNum;
@property(nonatomic,strong) NSString *areaId;
/**
 初始化

 @param phoneCodeButton 点击发送验证码的按钮
 @return JMPhoneCodeTool对象
 */
-(instancetype)initWithPhoneCodeButton:(UIButton *)phoneCodeButton requestParams:(NSDictionary *)params;
/**
 发送验证码
 */
-(void)sendPhoneCode;

/**
 停止计时(退出时销毁)
 */
-(void)stopTimer;
@end
