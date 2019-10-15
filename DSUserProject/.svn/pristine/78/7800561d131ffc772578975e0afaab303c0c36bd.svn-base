//
//  LiveLevelRecordModel.h
//  JMBaseProject
//
//  Created by Liuny on 2019/9/16.
//  Copyright © 2019 liuny. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LiveLevelRecordModel : NSObject
/*
 0翠友每月扣铁值
 1观看直播满10分钟
 2观看直播满20分钟
 3分享直播间
 4关注直播间，首次
 5给直播间点赞3次
 6发言10条/天
 7签收宝贝
 8连续观看7天满10分钟以上直播
 */
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *value;
@property (nonatomic, copy) NSString *time;

-(instancetype)initWithDictionary:(NSDictionary *)dict;
-(NSString *)iconImageName;
@end

NS_ASSUME_NONNULL_END
