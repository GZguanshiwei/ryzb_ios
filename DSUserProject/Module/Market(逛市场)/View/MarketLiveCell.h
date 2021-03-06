//
//  MarketLiveCell.h
//  JMBaseProject
//
//  Created by Liuny on 2019/6/15.
//  Copyright © 2019 liuny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiveRoomModel.h"

NS_ASSUME_NONNULL_BEGIN
static NSString *marketLiveCellID = @"MarketLiveCellID";
@interface MarketLiveCell : UICollectionViewCell
@property (nonatomic, strong) LiveRoomModel *cellData;
@end

NS_ASSUME_NONNULL_END
