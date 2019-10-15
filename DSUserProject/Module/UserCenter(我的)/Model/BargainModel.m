//
//  BargainModel.m
//  JMBaseProject
//
//  Created by Liuny on 2019/9/12.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "BargainModel.h"
#import <DateTools.h>

@implementation BargainModel
-(instancetype)initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    if(self){
        self.bargainId = [dict getJsonValue:@"id"];
        self.coverImage = [dict getJsonValue:@"thumbnail"];
        self.status = [dict getJsonValue:@"status"];
        self.createTime = [dict getJsonValue:@"createTime"];
        self.downMoney = [dict getJsonValue:@"price"];
        self.name = [dict getJsonValue:@"name"];
        self.goodId = [dict getJsonValue:@"goodsId"];
        
        self.goodPrice = [dict getJsonValue:@"goodsPrice"];
        if(self.goodPrice.length == 0){
            NSDictionary *goodDic = dict[@"goods"];
            self.goodPrice = [goodDic getJsonValue:@"price"];
        }
    }
    return self;
}


-(NSString *)showTime{
    NSDate *startTime = [NSDate dateWithString:self.createTime format:@"yyyy-MM-dd HH:mm:ss"];
    //砍价一天结束（24小时）
    NSDate *endTime = [startTime dateByAddingHours:24];
    double seconds = [endTime secondsUntil];
    NSInteger hour = floor(seconds/SECONDS_IN_HOUR);
    NSInteger minute = floor((seconds - hour*SECONDS_IN_HOUR)/SECONDS_IN_MINUTE);
    NSInteger second = seconds - hour*SECONDS_IN_HOUR - minute*SECONDS_IN_MINUTE;
    if(seconds <= 0 && self.status.integerValue == 0){
        self.status = @"2";
    }
    NSString *showTime = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",(long)hour,(long)minute,(long)second];
    return showTime;
}
@end
