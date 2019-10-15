//
//  WalletAccountListModel.m
//  JMBaseProject
//
//  Created by 抽筋的灯 on 2019/9/10.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "WalletAccountListModel.h"

@implementation WalletAccountListModel

-(instancetype)initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    if(self){
        self = [WalletAccountListModel mj_objectWithKeyValues:dict];
    }
    return self;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    //前边的是你想用的key，后边的是返回的key
    return @{
             @"modelId" : @"id"
             };
}

@end
