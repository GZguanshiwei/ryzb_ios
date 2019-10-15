//
//  ReceiveOrderView.h
//  JMBaseProject
//
//  Created by Liuny on 2019/7/18.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "JMPopoverCenterView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ReceiveOrderView : JMPopoverCenterView
@property (nonatomic, copy) NSString *orderId;
@property (nonatomic, copy) NSString *payMoney;
@property (nonatomic, assign) BOOL inGroup;
@end

NS_ASSUME_NONNULL_END
