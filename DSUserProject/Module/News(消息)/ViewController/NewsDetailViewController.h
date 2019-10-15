//
//  NewsDetailViewController.h
//  JMBaseProject
//
//  Created by Liuny on 2019/6/19.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "JMBaseViewController.h"
#import "NewsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewsDetailViewController : JMBaseViewController
@property (nonatomic, strong) NewsModel *notice;
@end

NS_ASSUME_NONNULL_END
