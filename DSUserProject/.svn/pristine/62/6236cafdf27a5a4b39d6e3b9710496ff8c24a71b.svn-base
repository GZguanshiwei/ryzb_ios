//
//  RoomDetailModel.m
//  JMBaseProject
//
//  Created by Liuny on 2019/7/13.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "RoomDetailModel.h"

@implementation RoomDetailModel
-(instancetype)initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    if(self){
        self.roomId = [dict getJsonValue:@"id"];
        self.roomNo = [dict getJsonValue:@"roomNumber"];
        self.name = [dict getJsonValue:@"name"];
        self.zanNum = [dict getJsonValue:@"zanNumber"];
        self.startTime = [dict getJsonValue:@"createTime"];
        self.onlinePeopleNum = [dict getJsonValue:@"watchNumber"];
        self.coverImage = [dict getJsonValue:@"image"];
        self.noticeContent = [dict getJsonValue:@"announcement"];
        self.creatorDesc = [dict getJsonValue:@"anchorIntroduction"];
        self.creatorId = [dict getJsonValue:@"accountId"];
        self.address = [dict getJsonValue:@"address"];
        self.roomDesc = [dict getJsonValue:@"roomIntroduction"];
        self.creatorHead = [dict getJsonValue:@"head"];
        self.creatorName = [dict getJsonValue:@"nick"];
        self.isAttention = [dict getJsonValue:@"isFollow"].boolValue;
        self.commentNum = [dict getJsonValue:@"commentNum"];
    }
    return self;
}
@end
