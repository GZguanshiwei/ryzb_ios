//
//  DailyTasksModel.m
//  JMBaseProject
//
//  Created by 抽筋的灯 on 2019/9/17.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "DailyTasksModel.h"

@implementation DailyTasksModel

-(instancetype)initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    if(self){
        self.tasksId = [dict getJsonValue:@"id"];
        self.name = [dict getJsonValue:@"name"];
        self.coverUrl = [dict getJsonValue:@"desc"];
        self.value = [dict getJsonValue:@"value"];
        self.completed = [dict getJsonValue:@"completed"];
    }
    return self;
}

@end
