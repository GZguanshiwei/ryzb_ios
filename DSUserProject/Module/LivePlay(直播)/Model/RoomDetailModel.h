//
//  RoomDetailModel.h
//  JMBaseProject
//
//  Created by Liuny on 2019/7/13.
//  Copyright © 2019 liuny. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RoomDetailModel : NSObject
@property (nonatomic, copy) NSString *roomId;
@property (nonatomic, copy) NSString *roomNo;//房间编号
@property (nonatomic, copy) NSString *name;//直播间名称
@property (nonatomic, copy) NSString *noticeContent;//公告
@property (nonatomic, copy) NSString *onlinePeopleNum;//观看人数
@property (nonatomic, copy) NSString *startTime;//开始直播时间
@property (nonatomic, copy) NSString *zanNum;//点赞数量
@property (nonatomic, copy) NSString *shareUrl;//分享地址
@property (nonatomic, copy) NSString *roomDesc;//直播间简介
@property (nonatomic, copy) NSString *address;//地址
@property (nonatomic, copy) NSString *coverImage;//封面图
@property (nonatomic, assign) BOOL isAttention;//是否关注
@property (nonatomic, copy) NSString *commentNum;//商品评论数

//创建者
@property (nonatomic, copy) NSString *creatorId;//创建者id
@property (nonatomic, copy) NSString *creatorName;
@property (nonatomic, copy) NSString *creatorHead;
@property (nonatomic, copy) NSString *creatorDesc;//主播简介

-(instancetype)initWithDictionary:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
