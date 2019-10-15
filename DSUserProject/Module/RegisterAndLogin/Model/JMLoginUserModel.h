//
//  JMLoginUserModel.h
//  JMBaseProject
//
//  Created by liuny on 2018/7/15.
//  Copyright © 2018年 liuny. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kLoginUserSavePath [[UIApplication sharedApplication].documentsPath stringByAppendingPathComponent:@"user"]

@interface JMLoginUserModel : NSObject
@property (nonatomic, copy) NSString *sessionId;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *headUrl;
@property (nonatomic, copy) NSString *txUserSig;
@property (nonatomic, copy) NSString *userType;//0:系统管理 1:普通客户 2:商家 3:主播 4:房管
@property (nonatomic, copy) NSString *withdrawBlance;//可提现金额
@property (nonatomic, assign) BOOL hasPayPassword;//支付密码
@property (nonatomic, copy) NSString *mobile;//登录绑定手机号码
@property (nonatomic, copy) NSString *shopMobile;//店铺手机号码
@property (nonatomic, copy) NSString *integral;//积分
@property (nonatomic, copy) NSString *grade;//会员等级

-(instancetype)initWithLoginDictionary:(NSDictionary *)dict;
-(void)updateWithUserInfoDictionary:(NSDictionary *)dict;
-(void)save;
-(void)clear;

@end
