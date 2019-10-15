//
//  LiveJianBaoViewController.h
//  JMBaseProject
//
//  Created by Liuny on 2019/9/20.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "JMBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LiveJianBaoViewController : JMBaseViewController
@property (nonatomic, copy) void(^selectBlock)(NSDictionary *params);
@end

NS_ASSUME_NONNULL_END
