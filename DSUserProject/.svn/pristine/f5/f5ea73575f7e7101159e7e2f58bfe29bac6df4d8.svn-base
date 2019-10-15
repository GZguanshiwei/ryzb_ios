//
//  MemberModel.m
//  JMBaseProject
//
//  Created by 抽筋的灯 on 2019/9/9.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "MemberModel.h"

@implementation MemberModel

-(instancetype)initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    if(self){
        self.experience = [dict getJsonValue:@"experience"];
        NSDictionary *nowDict = dict[@"nowMember"];
        self.grade = [nowDict getJsonValue:@"grade"];
        self.gradeName = [nowDict getJsonValue:@"name"];
        self.integral = [nowDict getJsonValue:@"integral"];
        self.invitationRebate = [nowDict getJsonValue:@"invitationRebate"];
        self.appraisalFree = [nowDict getJsonValue:@"appraisalFree"].boolValue;
        
        NSDictionary *nextDict = dict[@"nextMember"];
        self.nextGrade = [nextDict getJsonValue:@"grade"];
        self.nextGradeName = [nextDict getJsonValue:@"name"];
        self.nextIntegral = [nextDict getJsonValue:@"integral"];
    }
    return self;
}


@end
