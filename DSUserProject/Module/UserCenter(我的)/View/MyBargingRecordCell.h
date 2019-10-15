//
//  MyBargingRecordCell.h
//  JMBaseProject
//
//  Created by 潘传标 on 2019/9/6.
//  Copyright © 2019 liuny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BargainUserModel.h"

NS_ASSUME_NONNULL_BEGIN
static NSString *myBargingRecordCellID = @"MyBargingRecordCellID";
@interface MyBargingRecordCell : UITableViewCell
@property (nonatomic, strong) BargainUserModel *cellData;
@end

NS_ASSUME_NONNULL_END
