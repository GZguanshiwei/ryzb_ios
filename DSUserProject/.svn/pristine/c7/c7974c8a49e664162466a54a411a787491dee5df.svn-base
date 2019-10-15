//
//  NewsModel.m
//  JMBaseProject
//
//  Created by Liuny on 2019/7/13.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel
-(instancetype)initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    if(self){
        self.noticeId = [dict getJsonValue:@"noticeId"];
        self.content = [dict getJsonValue:@"content"];
        self.time = [dict getJsonValue:@"createTime"];
        self.coverImage = [dict getJsonValue:@"image"];
        self.title = [dict getJsonValue:@"title"];
    }
    return self;
}
@end
