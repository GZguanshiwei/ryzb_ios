//
//  LogisticsModel.m
//  JMBaseProject
//
//  Created by Liuny on 2019/7/16.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "LogisticsModel.h"

@implementation LogisticsModel
-(instancetype)initWithDictionary:(NSDictionary *)dict state:(NSString *)state{
    self = [super init];
    if(self){
        self.content = [dict getJsonValue:@"AcceptStation"];
        self.dateAndTime = [dict getJsonValue:@"AcceptTime"];
        self.state = state;
    }
    return self;
}

-(NSString *)showDate{
    NSString *rtn = @"";
    NSDate *date = [NSDate dateWithString:self.dateAndTime format:@"yyyy-MM-dd HH:mm:ss"];
    BOOL isToday = [[NSCalendar currentCalendar] isDateInToday:date];
    BOOL isYesterday = [[NSCalendar currentCalendar] isDateInYesterday:date];
    if(isToday){
        rtn = @"今天";
    }else if(isYesterday){
        rtn = @"昨天";
    }else{
        rtn = [date stringWithFormat:@"yyyy-MM-dd"];
    }
    return rtn;
}

-(NSString *)showTime{
    NSString *rtn = @"";
    NSDate *date = [NSDate dateWithString:self.dateAndTime format:@"yyyy-MM-dd HH:mm:ss"];
    rtn = [date stringWithFormat:@"HH:mm"];
    return rtn;
}
@end
