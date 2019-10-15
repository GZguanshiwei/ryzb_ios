//
//  MyBargaingListCell.h
//  JMBaseProject
//
//  Created by 潘传标 on 2019/9/6.
//  Copyright © 2019 liuny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BargainModel.h"

NS_ASSUME_NONNULL_BEGIN
static NSString *myBargaingListCellID = @"MyBargaingListCellID";
@interface MyBargaingListCell : UITableViewCell

@property (nonatomic, strong) BargainModel *cellData;
@property(nonatomic,copy)void(^buttonActionBlock)(NSInteger index);

@end

NS_ASSUME_NONNULL_END
