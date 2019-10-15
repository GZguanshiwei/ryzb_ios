//
//  WalletAccountListModel.h
//  JMBaseProject
//
//  Created by 抽筋的灯 on 2019/9/10.
//  Copyright © 2019 liuny. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WalletAccountListModel : NSObject

@property (nonatomic, copy) NSString *modelId;
@property (nonatomic, copy) NSString *account;//账号/卡号
@property (nonatomic, copy) NSString *bankName;//银行名称
@property (nonatomic, copy) NSString *name;//姓名
@property (nonatomic, copy) NSString *type;//提现方式1银行卡2微信3支付宝

-(instancetype)initWithDictionary:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
