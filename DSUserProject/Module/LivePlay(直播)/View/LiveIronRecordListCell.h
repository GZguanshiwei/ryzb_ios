//
//  LiveIronRecordListCell.h
//  JMBaseProject
//
//  Created by 潘传标 on 2019/9/4.
//  Copyright © 2019 liuny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiveLevelRecordModel.h"
#import "LevelRecordModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LiveIronRecordListCell : UITableViewCell
@property (nonatomic, strong) LiveLevelRecordModel *cellData;
@property (nonatomic, strong) LevelRecordModel *ucLevelData;
@end

NS_ASSUME_NONNULL_END
