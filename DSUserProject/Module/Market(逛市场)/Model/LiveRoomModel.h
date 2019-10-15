//
//  LiveRoomModel.h
//  JMBaseProject
//
//  Created by Liuny on 2019/7/5.
//  Copyright © 2019 liuny. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LiveRoomModel : NSObject

@property (nonatomic, copy) NSString *roomId;
@property (nonatomic, copy) NSString *coverImage;
@property (nonatomic, copy) NSString *bigCoverImage;
@property (nonatomic, copy) NSString *roomNo;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *notice;
@property (nonatomic, copy) NSString *state;//0直播中1冻结2离线
@property (nonatomic, copy) NSString *onlinePeople;

//直播间消息
@property (nonatomic, copy) NSString *msgHead;
@property (nonatomic, copy) NSString *msgText;

//创建者
@property (nonatomic, copy) NSString *anchorDesc;
@property (nonatomic, copy) NSString *anchorId;
@property (nonatomic, copy) NSString *anchorHead;
@property (nonatomic, copy) NSString *anchorName;

-(instancetype)initWithDictionary:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
