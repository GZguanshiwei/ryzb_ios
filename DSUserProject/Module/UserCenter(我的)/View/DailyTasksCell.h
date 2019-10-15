//
//  DailyTasksCell.h
//  JMBaseProject
//
//  Created by 抽筋的灯 on 2019/9/17.
//  Copyright © 2019 liuny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DailyTasksModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DailyTasksCellDelegate <NSObject>

- (void)completeButtondDid:(NSInteger)index;

@end

@interface DailyTasksCell : UITableViewCell

@property (nonatomic, strong) DailyTasksModel *cellData;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, weak) id<DailyTasksCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
