//
//  LevelRecordModel.m
//  JMBaseProject
//
//  Created by Liuny on 2019/9/25.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "LevelRecordModel.h"

@implementation LevelRecordModel
-(instancetype)initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    if(self){
        self.type = [dict getJsonValue:@"type"];
        self.title = [dict getJsonValue:@"name"];
        self.value = [dict getJsonValue:@"integral"];
        self.time = [dict getJsonValue:@"createTime"];
        self.image = [dict getJsonValue:@"image"];
    }
    return self;
}

-(NSString *)iconImageName{
    NSString *rtn;
    switch (self.type.intValue) {
        case 0:
            //观看直播满10分钟
            rtn = @"live_pop_level_icon_watch";
            break;
        case 1:
            //邀请好友下载app并注册
            rtn = @"vip_icon_invite";
            break;
        case 2:
            //分享直播间，每天1次
            rtn = @"live_pop_level_icon_share";
            break;
        case 3:
            //购买宝贝，确认收货后获成长值
            rtn = @"vip_icon_buy";
            break;
        case 4:
            //评价宝贝
            rtn = @"live_pop_level_icon_speak";
            break;
        case 5:
            //分享宝贝
            rtn = @"vip_jfjl_icon_share";
            break;
        default:
            break;
    }
    return rtn;
}
@end
