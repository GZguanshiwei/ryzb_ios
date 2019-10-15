//
//  AddressAlertViewController.h
//  JMBaseProject
//
//  Created by Liuny on 2019/9/16.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "JMBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddressAlertViewController : JMBaseViewController
@property (nonatomic, copy) void(^selectBlock)(AddressModel *address);
@end

NS_ASSUME_NONNULL_END
