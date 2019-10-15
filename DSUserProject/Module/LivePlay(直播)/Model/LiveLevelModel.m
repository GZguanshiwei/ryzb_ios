//
//  LiveLevelModel.m
//  JMBaseProject
//
//  Created by 抽筋的灯 on 2019/9/19.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "LiveLevelModel.h"

@implementation LiveLevelModel

-(instancetype)initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    if(self){
        NSDictionary *gradeDict = dict[@"grade"];
        self.grade = [gradeDict getJsonValue:@"id"];
        
        NSDictionary *nextDict = dict[@"nextGrade"];
        self.nextGrade = [nextDict getJsonValue:@"id"];
        self.nextIronValue = [nextDict getJsonValue:@"ironValue"];
        
        self.ironValue = [dict getJsonValue:@"ironValue"];
        self.tenMin = [dict getJsonValue:@"tenMin"].boolValue;
        self.twentyMin = [dict getJsonValue:@"twentyMin"].boolValue;
        self.share = [dict getJsonValue:@"share"].boolValue;
        self.zan = [dict getJsonValue:@"admire"].boolValue;
        self.talk = [dict getJsonValue:@"talk"].boolValue;
    }
    return self;
}

@end
