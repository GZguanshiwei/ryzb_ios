//
//  IntegralGoodModel.m
//  JMBaseProject
//
//  Created by Liuny on 2019/9/11.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "IntegralGoodModel.h"

@implementation IntegralGoodModel
-(instancetype)initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    if(self){
        self.goodId = [dict getJsonValue:@"id"];
        self.ids = [dict getJsonValue:@"ids"];
        self.name = [dict getJsonValue:@"name"];
        self.exchangeCount = [dict getJsonValue:@"salesVolume"];
        self.exchangeIntegral = [dict getJsonValue:@"integral"];
        self.type = [dict getJsonValue:@"type"];
        self.coverImage = [dict getJsonValue:@"image"];
    }
    return self;
}
@end
