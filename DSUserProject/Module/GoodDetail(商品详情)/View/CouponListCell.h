//
//  CouponListCell.h
//  JMBaseProject
//
//  Created by 潘传标 on 2019/9/5.
//  Copyright © 2019 liuny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCouponModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CouponListCell : UITableViewCell

@property (strong, nonatomic) MyCouponModel *cellData;
@property (nonatomic, assign) BOOL canUse;



@end

NS_ASSUME_NONNULL_END
