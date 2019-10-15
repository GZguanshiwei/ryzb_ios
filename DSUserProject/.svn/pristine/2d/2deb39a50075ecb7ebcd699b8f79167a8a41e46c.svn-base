//
//  LiveLevelRecordModel.m
//  JMBaseProject
//
//  Created by Liuny on 2019/9/16.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "LiveLevelRecordModel.h"

@implementation LiveLevelRecordModel
-(instancetype)initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    if(self){
        self.type = [dict getJsonValue:@"type"];
        self.title = [dict getJsonValue:@"message"];
        self.value = [dict getJsonValue:@"ironValue"];
        self.time = [dict getJsonValue:@"createTime"];
    }
    return self;
}


/*
0翠友每月扣铁值
1观看直播满10分钟
2观看直播满20分钟
3分享直播间
4关注直播间，首次
5给直播间点赞3次
6发言10条/天
7签收宝贝
8连续观看7天满10分钟以上直播
*/
-(NSString *)iconImageName{
    NSString *rtn;
    switch (self.type.intValue) {
        case 0:
            rtn = @"live_pop_level_icon_watch";
            break;
        case 1:
        case 2:
        case 8:
            rtn = @"live_pop_level_icon_watch";
        case 3:
            rtn = @"live_pop_level_icon_share";
            break;
        case 4:
            rtn = @"live_pop_level_icon_follow";
            break;
        case 5:
            rtn = @"live_pop_level_icon_like";
            break;
        case 6:
            rtn = @"live_pop_level_icon_speak";
            break;
        case 7:
            rtn = @"live_pop_level_icon_qs";
            break;
        default:
            break;
    }
    return rtn;
}

@end
