//
//  GoodDetailModel.h
//  JMBaseProject
//
//  Created by Liuny on 2019/7/13.
//  Copyright © 2019 liuny. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GoodDetailInfoItemModel:NSObject
@property (nonatomic, copy) NSString *infoTip;
@property (nonatomic, copy) NSString *infoContent;

-(instancetype)initWithDictionary:(NSDictionary *)dict;
@end


@interface GoodDetailModel : GoodModel
/*
@property (nonatomic, copy) NSString *goodId;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *coverImage;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *resalePrice;
@property (nonatomic, copy) NSString *videoUrl;
@property (nonatomic, copy) NSString *resaleNum;
@property (nonatomic, copy) NSString *collectedNum;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *resaleContent;
@property (nonatomic, assign) BOOL isCollected;
 */

@property (nonatomic, copy) NSString *oldPrice;
@property (nonatomic, copy) NSString *labelId;
@property (nonatomic, copy) NSString *roomId;
@property (nonatomic, copy) NSString *detailedText;
@property (copy, nonatomic) NSString *specification;//商品规格
@property (copy, nonatomic) NSString *content;//商品规格

@property (nonatomic, strong) NSMutableArray *bannerImages;
@property (nonatomic, strong) NSMutableArray *infoImages;
@property (nonatomic, strong) NSMutableArray <GoodDetailInfoItemModel *>*infoItems;
@property (nonatomic, strong) NSMutableArray <GoodModel *>*recommendGoods;
@property (nonatomic, assign) BOOL isLive;//是否正在直播
@property (nonatomic, copy) NSString *sellState;//0:已结缘 1:有货

//评论
@property (nonatomic, copy) NSString *commentName;
@property (nonatomic, copy) NSString *commentHead;
@property (nonatomic, copy) NSString *commentContent;
@property (nonatomic, copy) NSString *commentId;

-(instancetype)initWithDetailDictionary:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
