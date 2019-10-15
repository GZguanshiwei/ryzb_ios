//
//  BannerModel.m
//  JMBaseProject
//
//  Created by Liuny on 2018/12/19.
//  Copyright © 2018 liuny. All rights reserved.
//

#import "BannerModel.h"

@implementation BannerModel
-(instancetype)initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    if(self){
        self.modelId = [dict getJsonValue:@"id"];
        self.imageUrl = [dict getJsonValue:@"image"];
        self.title = [dict getJsonValue:@"name"];
        self.goUrl = [dict getJsonValue:@"link"];
        self.ids = [dict getJsonValue:@"ids"];
        self.type = [dict getJsonValue:@"state"];
    }
    return self;
}
@end
