//
//  GoodModel.m
//  JMBaseProject
//
//  Created by Liuny on 2019/7/9.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "GoodModel.h"

@implementation GoodModel
-(instancetype)initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    if(self){
        self.goodId = [dict getJsonValue:@"id"];
        self.title = [dict getJsonValue:@"name"];
        self.coverImage = [dict getJsonValue:@"thumbnail"];
        self.price = [dict getJsonValue:@"price"];
        self.videoUrl = [dict getJsonValue:@"video"];
        self.resaleNum = [dict getJsonValue:@"resaleNum"];
        self.collectedNum = [dict getJsonValue:@"collectedNum"];
        self.isCollected = [dict getJsonValue:@"isCollected"].boolValue;
        self.time = [dict getJsonValue:@"createTime"];
        self.resalePrice = [dict getJsonValue:@"resalePrice"];
        self.goodsResaleId = [dict getJsonValue:@"goodsResaleId"];
    }
    return self;
}

-(instancetype)initWithCollectionDictionary:(NSDictionary *)dict{
    self = [super init];
    if(self){
        self.goodId = [dict getJsonValue:@"goodsId"];
        self.title = [dict getJsonValue:@"goodsName"];
        self.price = [dict getJsonValue:@"price"];
        self.coverImage = [dict getJsonValue:@"goodsImg"];
        self.time = [dict getJsonValue:@"createTime"];
    }
    return self;
}

@end
