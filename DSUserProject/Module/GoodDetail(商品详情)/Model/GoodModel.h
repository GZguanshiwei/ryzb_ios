//
//  GoodModel.h
//  JMBaseProject
//
//  Created by Liuny on 2019/7/9.
//  Copyright © 2019 liuny. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GoodModel : NSObject
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
@property (nonatomic, copy) NSString *goodsResaleId;//转售商品id

@property (nonatomic, copy) NSString *afterSaleId;
@property (nonatomic, copy) NSString *refundNum;//申请售后的次数

-(instancetype)initWithDictionary:(NSDictionary *)dict;
-(instancetype)initWithCollectionDictionary:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
