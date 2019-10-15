//
//  HomeTypeViewController.h
//  JMBaseProject
//
//  Created by Liuny on 2019/6/21.
//  Copyright © 2019 liuny. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeTypeViewController : JMBaseViewController
@property (nonatomic, strong) NSMutableArray *typesArray;
@property (nonatomic, copy) void(^selectBlock)(NSInteger index);
@end

NS_ASSUME_NONNULL_END
