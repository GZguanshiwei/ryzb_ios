//
//  DailyTasksModel.h
//  JMBaseProject
//
//  Created by 抽筋的灯 on 2019/9/17.
//  Copyright © 2019 liuny. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DailyTasksModel : NSObject

@property (nonatomic, copy) NSString *tasksId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *coverUrl;
@property (nonatomic, copy) NSString *value;
@property (nonatomic, copy) NSString *completed;

-(instancetype)initWithDictionary:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
