//
//  BargainUserModel.m
//  JMBaseProject
//
//  Created by Liuny on 2019/9/12.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "BargainUserModel.h"

@implementation BargainUserModel
-(instancetype)initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    if(self){
        self.userHead = [dict getJsonValue:@"head"];
        self.userName = [dict getJsonValue:@"nick"];
        self.time = [dict getJsonValue:@"createTime"];
        self.downMoney = [dict getJsonValue:@"bargainPrice"];
    }
    return self;
}
@end
