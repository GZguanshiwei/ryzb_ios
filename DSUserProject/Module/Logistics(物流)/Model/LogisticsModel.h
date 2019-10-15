//
//  LogisticsModel.h
//  JMBaseProject
//
//  Created by Liuny on 2019/7/16.
//  Copyright © 2019 liuny. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LogisticsModel : NSObject
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *dateAndTime;
@property (nonatomic, assign) BOOL isFirstOne;
@property (nonatomic, assign) BOOL isLastOne;
@property (nonatomic, copy) NSString *state; //0:无轨迹 1:已揽收 2:在途中 3:签收 4:问题件

-(instancetype)initWithDictionary:(NSDictionary *)dict state:(NSString *)state;

-(NSString *)showDate;
-(NSString *)showTime;
@end

NS_ASSUME_NONNULL_END
