//
//  SearchDefaultViewController.h
//  JMBaseProject
//
//  Created by Liuny on 2019/7/2.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "JMBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SearchDefaultViewController : JMBaseViewController
@property (nonatomic, copy) void(^selectBlock)(NSString *searchKey);
@end

NS_ASSUME_NONNULL_END
