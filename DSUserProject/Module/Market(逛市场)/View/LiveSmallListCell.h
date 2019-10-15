//
//  LiveSmallListCell.h
//  JMBaseProject
//
//  Created by 潘传标 on 2019/9/3.
//  Copyright © 2019 liuny. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
static NSString *liveSmallListCellID = @"LiveSmallListCellID";
@class LiveRoomModel;
@interface LiveSmallListCell : UICollectionViewCell
@property(nonatomic,strong)LiveRoomModel *roomModel;
@end

NS_ASSUME_NONNULL_END
