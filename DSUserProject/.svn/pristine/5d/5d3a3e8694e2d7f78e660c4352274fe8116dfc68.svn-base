//
//  WalletRecordModel.m
//  JMBaseProject
//
//  Created by Liuny on 2019/7/13.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "WalletRecordModel.h"

@implementation WalletRecordModel
-(instancetype)initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    if(self){
        self.recordId = [dict getJsonValue:@"id"];
        self.time = [dict getJsonValue:@"createTime"];
        self.withdrawState = [dict getJsonValue:@"state"];
        self.type = [dict getJsonValue:@"msgType"];
        self.amount = [dict getJsonValue:@"amount"];
    }
    return self;
}
@end
