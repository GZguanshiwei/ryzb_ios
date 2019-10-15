//
//  LiveGiftViewController.h
//  JMBaseProject
//
//  Created by Liuny on 2019/9/19.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "JMBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LiveGiftViewController : JMBaseViewController
@property (nonatomic, strong) NSString *toAccountId;

@property (nonatomic, copy) void(^successBlock)(NSDictionary *params);
@end

NS_ASSUME_NONNULL_END
