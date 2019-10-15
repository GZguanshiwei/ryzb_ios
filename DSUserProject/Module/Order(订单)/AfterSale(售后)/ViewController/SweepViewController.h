//
//  SweepViewController.h
//  JMBaseProject
//
//  Created by Liuny on 2019/2/14.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "JMBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SweepViewController : JMBaseViewController
@property (nonatomic, copy) void(^finishBlock)(NSString *result);
@end

NS_ASSUME_NONNULL_END
