//
//  OrderListViewController.h
//  JMBaseProject
//
//  Created by Liuny on 2018/12/28.
//  Copyright © 2018 liuny. All rights reserved.
//

#import "JMBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderListViewController : JMBaseViewController
@property(nonatomic, assign) NSInteger type;//0:全部 1:待付款 2:待发货 3:待收货 4:待评价
@end

NS_ASSUME_NONNULL_END
