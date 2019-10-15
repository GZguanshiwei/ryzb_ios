//
//  GroupModel.m
//  JMBaseProject
//
//  Created by Liuny on 2019/1/3.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "GroupModel.h"

@implementation GroupModel
-(instancetype)initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    if(self){
        self.groupId = [dict getJsonValue:@"id"];
        self.groupName = [dict getJsonValue:@"name"];
        self.groupCoverImage = [dict getJsonValue:@"image"];
    }
    return self;
}
@end
