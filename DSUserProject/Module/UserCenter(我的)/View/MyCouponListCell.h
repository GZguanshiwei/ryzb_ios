//
//  MyCouponListCell.h
//  JMBaseProject
//
//  Created by 潘传标 on 2019/9/6.
//  Copyright © 2019 liuny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCouponModel.h"

NS_ASSUME_NONNULL_BEGIN
static NSString *myCouponListCellID = @"MyCouponListCellID";
@interface MyCouponListCell : UITableViewCell

@property(nonatomic,copy)void(^buttonActionBlock)(NSInteger index);
@property (weak, nonatomic) IBOutlet UIButton *typeButton;
@property (strong, nonatomic) MyCouponModel *cellData;

@end

NS_ASSUME_NONNULL_END
