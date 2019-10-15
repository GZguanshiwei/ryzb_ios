//
//  LiveCell.h
//  JMBaseProject
//
//  Created by Liuny on 2019/6/28.
//  Copyright © 2019 liuny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiveRoomModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LiveCell : UICollectionViewCell
@property (strong, nonatomic) LiveRoomModel *cellData;
@end

NS_ASSUME_NONNULL_END
