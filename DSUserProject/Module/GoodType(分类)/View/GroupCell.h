//
//  GroupCell.h
//  JMBaseProject
//
//  Created by Liuny on 2019/1/3.
//  Copyright © 2019 liuny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GroupCell : UITableViewCell
@property (strong, nonatomic) GroupModel *cellData;
@end

NS_ASSUME_NONNULL_END
