//
//  ScreenCenterTipView.h
//  JMBaseProject
//
//  Created by ios on 2018/12/28.
//  Copyright © 2018 liuny. All rights reserved.
//

#import "JMPopoverCenterView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ScreenCenterTipView : JMPopoverCenterView

@property (nonatomic, strong) NSString *message; 
@property (nonatomic, strong) NSArray *buttonTitles;

@end

NS_ASSUME_NONNULL_END
