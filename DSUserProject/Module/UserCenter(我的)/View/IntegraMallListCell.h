//
//  IntegraMallListCell.h
//  JMBaseProject
//
//  Created by 潘传标 on 2019/9/6.
//  Copyright © 2019 liuny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntegralGoodModel.h"

NS_ASSUME_NONNULL_BEGIN
static NSString *integraMallListCellID = @"IntegraMallListCellID";
@interface IntegraMallListCell : UICollectionViewCell
@property (strong, nonatomic) IntegralGoodModel *cellData;
@end

NS_ASSUME_NONNULL_END
