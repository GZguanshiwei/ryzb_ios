//
//  GroupViewController.h
//  JMBaseProject
//
//  Created by Liuny on 2019/1/3.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "JMBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface GroupLevelOneViewController : JMBaseViewController
@property (nonatomic, copy) void(^changeGroupBlock)(NSString *groupId);

@end

NS_ASSUME_NONNULL_END
