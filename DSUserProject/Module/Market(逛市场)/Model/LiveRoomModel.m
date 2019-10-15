//
//  LiveRoomModel.m
//  JMBaseProject
//
//  Created by Liuny on 2019/7/5.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "LiveRoomModel.h"

@implementation LiveRoomModel

-(instancetype)initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    if(self){
        self.roomId = [dict getJsonValue:@"id"];
        self.roomNo = [dict getJsonValue:@"id"];
        self.city = [dict getJsonValue:@"address"];
        self.coverImage = [dict getJsonValue:@"image2"];
        self.notice = [dict getJsonValue:@"announcement"];
        self.desc = [dict getJsonValue:@"desc"];
        self.name = [dict getJsonValue:@"name"];
        self.state = [dict getJsonValue:@"state"];
        self.onlinePeople = [dict getJsonValue:@"watchNumber"];
         
        self.anchorId = [dict getJsonValue:@"accountId"];
        self.anchorDesc = [dict getJsonValue:@"anchorIntroduction"];
        self.anchorName = [dict getJsonValue:@"nick"];
        self.anchorHead = [dict getJsonValue:@"head"];
        self.bigCoverImage = [dict getJsonValue:@"image"];
        
        //保证总是有图片显示
        if(JMIsEmpty(self.coverImage)){
            self.coverImage = self.bigCoverImage;
        }
        if(JMIsEmpty(self.bigCoverImage)){
            self.bigCoverImage = self.coverImage;
        }
        
        //消息
        NSDictionary *msgDic = dict[@"msg"];
        if([msgDic isKindOfClass:[NSDictionary class]]){
            self.msgHead = [msgDic getJsonValue:@"headPic"];
            self.msgText = [msgDic getJsonValue:@"text"];
        }
    }
    return self;
}
@end
