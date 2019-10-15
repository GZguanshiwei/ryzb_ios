//
//  BargainModel.h
//  JMBaseProject
//
//  Created by Liuny on 2019/9/12.
//  Copyright © 2019 liuny. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BargainModel : NSObject
@property (nonatomic, copy) NSString *bargainId;
@property (nonatomic, copy) NSString *coverImage;
@property (nonatomic, copy) NSString *status;//0正常1砍价成功2砍价失败
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *goodId;
@property (nonatomic, copy) NSString *downMoney;
@property (nonatomic, copy) NSString *goodPrice;

-(instancetype)initWithDictionary:(NSDictionary *)dict;
-(NSString *)showTime;
@end

NS_ASSUME_NONNULL_END
