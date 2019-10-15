//
//  GoodDetailModel.m
//  JMBaseProject
//
//  Created by Liuny on 2019/7/13.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "GoodDetailModel.h"

@implementation GoodDetailInfoItemModel

-(instancetype)initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    if(self){
        self.infoTip = [dict getJsonValue:@"skuCode"];
        self.infoContent = [dict getJsonValue:@"name"];
    }
    return self;
}

@end

@implementation GoodDetailModel
-(instancetype)initWithDetailDictionary:(NSDictionary *)dict{
    self = [super init];
    if(self){
        self.goodId = [dict getJsonValue:@"id"];
        self.title = [dict getJsonValue:@"name"];
        self.coverImage = [dict getJsonValue:@"thumbnail"];
        self.price = [dict getJsonValue:@"price"];
        self.resalePrice = [dict getJsonValue:@"resalePrice"];
        self.collectedNum = [dict getJsonValue:@"collectedNum"];
        self.videoUrl = [dict getJsonValue:@"video"];
        self.oldPrice = [dict getJsonValue:@"oldPrice"];
        self.resaleNum = [dict getJsonValue:@"resaleNum"];
        self.isCollected = [dict getJsonValue:@"isCollected"].boolValue;
        self.labelId = [dict getJsonValue:@"labelId"];
        self.detailedText = [dict getJsonValue:@"content"];
        self.specification = [dict getJsonValue:@"remark"];
        
        //轮播图
        NSArray *ownerList = dict[@"ownerList"];
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for(NSDictionary *dic in ownerList){
            [array addObject:[dic getJsonValue:@"image"]];
        }
        self.bannerImages = array;
        
        //详情图片
        NSArray *detailsList = dict[@"detailsList"];
        NSMutableArray *array1 = [[NSMutableArray alloc] init];
        for(NSDictionary *dic in detailsList){
            [array1 addObject:[dic getJsonValue:@"image"]];
        }
        self.infoImages = array1;
        
        //推荐商品
        NSArray *recommendList = dict[@"recommendList"];
        NSMutableArray *array2 = [[NSMutableArray alloc] init];
        for(NSDictionary *dic in recommendList){
            GoodModel *good = [[GoodModel alloc] initWithDictionary:dic];
            [array2 addObject:good];
        }
        self.recommendGoods = array2;
        
        self.isLive = [dict getJsonValue:@"isBroad"].boolValue;
        self.sellState = [dict getJsonValue:@"sellState"];
        NSDictionary *roomDic = dict[@"room"];
        self.roomId = [roomDic getJsonValue:@"id"];
        
        //详情
        NSArray *skuList = dict[@"skuList"];
        NSMutableArray *array3 = [[NSMutableArray alloc] init];
        for(NSDictionary *dic in skuList){
            GoodDetailInfoItemModel *item = [[GoodDetailInfoItemModel alloc] initWithDictionary:dic];
            [array3 addObject:item];
        }
        self.infoItems = array3;
        
        //评论
        NSDictionary *commentDic = dict[@"goodsComment"];
        self.commentName = [commentDic getJsonValue:@"nick"];
        self.commentHead = [commentDic getJsonValue:@"head"];
        self.commentContent = [commentDic getJsonValue:@"content"];
        self.commentId = [commentDic getJsonValue:@"id"];
    }
    return self;
}
@end
