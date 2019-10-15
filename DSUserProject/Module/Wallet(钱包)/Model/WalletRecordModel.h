//
//  WalletRecordModel.h
//  JMBaseProject
//
//  Created by Liuny on 2019/7/13.
//  Copyright © 2019 liuny. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WalletRecordModel : NSObject
@property (nonatomic, copy) NSString *recordId;
@property (nonatomic, copy) NSString *amount;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *type;//1邀请返利2提现3提现失败
@property (nonatomic, copy) NSString *withdrawState;//如果是提现的提现状态(0未审核1通过2不通过)

-(instancetype)initWithDictionary:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
