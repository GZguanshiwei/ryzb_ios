//
//  ReceiveGiftManager.h
//  JMBaseProject
//
//  Created by liuny on 2018/7/13.
//  Copyright © 2018年 liuny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReceiveGiftModel.h"
#import "TCMsgModel.h"
@interface ReceiveGiftManager : NSObject
@property (nonatomic, weak) UIView *giftShowView;
// 显示礼物动画
-(void)setupGiftAnim:(TCMsgModel *)gift;
@end
