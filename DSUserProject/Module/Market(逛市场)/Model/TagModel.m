//
//  TagModel.m
//  JMBaseProject
//
//  Created by Liuny on 2018/11/9.
//  Copyright © 2018 liuny. All rights reserved.
//

#import "TagModel.h"

@implementation TagModel

MJCodingImplementation
-(instancetype)initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    if(self){
        self.tagId = [dict getJsonValue:@"id"];
        self.tagText = [dict getJsonValue:@"name"];
    }
    return self;
}

-(instancetype)initWithTagText:(NSString *)text{
    self = [super init];
    if(self){
        self.tagText = text;
        self.isSelect = NO;
    }
    return self;
}
@end
