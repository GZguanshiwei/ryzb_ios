//
//  AddressListCell.h
//  JMBaseProject
//
//  Created by Liuny on 2019/1/4.
//  Copyright © 2019 liuny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddressListCell : UITableViewCell
@property (nonatomic, strong) AddressModel *cellData;
@end

NS_ASSUME_NONNULL_END
