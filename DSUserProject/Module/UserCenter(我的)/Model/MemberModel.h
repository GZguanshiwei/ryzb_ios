//
//  MemberModel.h
//  JMBaseProject
//
//  Created by 抽筋的灯 on 2019/9/9.
//  Copyright © 2019 liuny. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MemberModel : NSObject

//当前等级
@property (nonatomic, copy) NSString *grade;
//当前经验值
@property (nonatomic, copy) NSString *experience;
//当前等级名称
@property (nonatomic, copy) NSString *gradeName;
//当前积分数
@property (nonatomic, copy) NSString *integral;
//下一级等级
@property (nonatomic, copy) NSString *nextGrade;
//下一级等级名称
@property (nonatomic, copy) NSString *nextGradeName;
//下一级积分数
@property (nonatomic, copy) NSString *nextIntegral;
//邀请返利百分比
@property (nonatomic, copy) NSString *invitationRebate;
//是否免鉴定费（0不是，1是）
@property (nonatomic, assign) BOOL appraisalFree;

-(instancetype)initWithDictionary:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
