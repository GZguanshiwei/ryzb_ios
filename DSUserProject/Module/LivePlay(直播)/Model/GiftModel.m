//
//  GiftModel.m
//  JMBaseProject
//
//  Created by Liuny on 2019/9/16.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "GiftModel.h"

@implementation GiftModel
-(instancetype)initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    if(self){
        self.giftId = [dict getJsonValue:@"id"];
        self.name = [dict getJsonValue:@"name"];
        self.image = [dict getJsonValue:@"image"];
        self.integral = [dict getJsonValue:@"integral"];
    }
    return self;
}
@end
