//
//  IntegralExchangeModel.m
//  JMBaseProject
//
//  Created by Liuny on 2019/9/12.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "IntegralExchangeModel.h"

@implementation IntegralExchangeModel
-(instancetype)initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    if(self){
        self.name = [dict getJsonValue:@"name"];
        self.coverImage = [dict getJsonValue:@"image"];
        self.time = [dict getJsonValue:@"createTime"];
        self.logistics = [dict getJsonValue:@"logistics"];
        self.type = [dict getJsonValue:@"type"];
    }
    return self;
}
@end
