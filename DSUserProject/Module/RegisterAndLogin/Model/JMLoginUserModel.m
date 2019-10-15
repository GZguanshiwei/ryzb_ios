//
//  JMLoginUserModel.m
//  JMBaseProject
//
//  Created by liuny on 2018/7/15.
//  Copyright © 2018年 liuny. All rights reserved.
//

#import "JMLoginUserModel.h"

@implementation JMLoginUserModel

MJCodingImplementation

-(instancetype)initWithLoginDictionary:(NSDictionary *)dict{
    self = [super init];
    if(self){
        self.sessionId = [dict getJsonValue:@"sessionId"];
        self.userId = [dict getJsonValue:@"id"];
        self.headUrl = [dict getJsonValue:@"head"];
        self.mobile = [dict getJsonValue:@"mobile"];
        self.userType = [dict getJsonValue:@"type"];
        self.txUserSig = [dict getJsonValue:@"userSig"];
        self.nickName = [dict getJsonValue:@"nick"];
    }
    return self;
}

-(void)updateWithUserInfoDictionary:(NSDictionary *)dict{
    self.headUrl = [dict getJsonValue:@"head"];
    self.nickName = [dict getJsonValue:@"nick"];
    self.shopMobile = [dict getJsonValue:@"mobile"];
    self.hasPayPassword = [dict getJsonValue:@"havePassword"].boolValue;
    self.integral = [dict getJsonValue:@"integral"];
    NSDictionary *nowDict = dict[@"nowMember"];
    self.grade = [nowDict getJsonValue:@"grade"];
}

- (void)save {
    [NSKeyedArchiver archiveRootObject:self toFile:kLoginUserSavePath];
}

- (void)clear {
    [[NSFileManager defaultManager] removeItemAtPath:kLoginUserSavePath error:nil];
}
@end
