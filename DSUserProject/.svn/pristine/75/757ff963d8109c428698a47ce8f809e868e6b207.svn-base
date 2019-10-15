//
//  MyCouponModel.m
//  JMBaseProject
//
//  Created by 抽筋的灯 on 2019/9/10.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "MyCouponModel.h"

@implementation MyCouponModel

-(instancetype)initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    if(self){
        self.couponId = [dict getJsonValue:@"id"];
        self.overTime = [dict getJsonValue:@"overTime"];
        NSDictionary *couponDic = dict[@"coupon"];
        self.name = [couponDic getJsonValue:@"name"];
        self.deductionPrice = [couponDic getJsonValue:@"deductionPrice"];
        self.restrictPrice = [couponDic getJsonValue:@"restrictPrice"];
        self.tips = [couponDic getJsonValue:@"tips"];
        self.type = [couponDic getJsonValue:@"type"];
        self.roomId = [couponDic getJsonValue:@"ids"];
        self.roomName = [couponDic getJsonValue:@"roomName"];
        
        self.canAddUse = NO;
        NSString *type1 = [dict getJsonValue:@"type"];
        NSString *type2 = [couponDic getJsonValue:@"state"];
        if(type1.intValue == 0 && type2.intValue == 0){
            self.canAddUse = YES;
        }
    }
    return self;
}

-(instancetype)initWithAlertDictionary:(NSDictionary *)dict{
    self = [super init];
    if(self){
        self.couponId = [dict getJsonValue:@"id"];
        self.name = [dict getJsonValue:@"name"];
        self.deductionPrice = [dict getJsonValue:@"deductionPrice"];
        self.restrictPrice = [dict getJsonValue:@"restrictPrice"];
        self.tips = [dict getJsonValue:@"tips"];
        self.roomId = [dict getJsonValue:@"ids"];
        self.roomName = [dict getJsonValue:@"roomName"];
        self.type = [dict getJsonValue:@"type"];
        
        NSString *day = [dict getJsonValue:@"overdueDay"];
        //接口是天，变成时间
        NSDate *startTime = [NSDate date];
        NSDate *endTime = [startTime dateByAddingDays:day.integerValue];
        self.overTime = [endTime stringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    return self;
}


-(NSString *)instructionsText{
    NSString *rtn = @"";
    switch (self.type.intValue) {
        case 0:
            rtn = @"本优惠券仅限商城宝贝可用，直播间不可用";
            break;
        case 1:
            rtn = [NSString stringWithFormat:@"本优惠券仅限%@直播间可用，商城不可用",self.roomName];
            break;
        case 2:
            rtn = @"本优惠券为通用优惠券";
            break;
        default:
            break;
    }
    return rtn;
}


+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    //前边的是你想用的key，后边的是返回的key
    return @{
             @"anchorId" : @"accountId",
             @"anchorName" : @"nick",
             @"anchorHeadUrl" : @"avatar",
             @"pictures" : @"imgs"
             };
}

@end
