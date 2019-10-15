//
//  ShareTipView.h
//  JMBaseProject
//
//  Created by Liuny on 2019/1/4.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "JMPopoverBottomView.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum{
    Share_Resale = 0,//转售
    Share_Invite,//邀请好友
    Share_Bargain,//邀请好友砍价
    Share_Shop,//分享店铺
    Share_Live,//分享直播间
}Share_Type;


@interface ShareTipView : JMPopoverBottomView

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) id image;//可以赋值图片路径、本地图片

-(void)showShareWithType:(Share_Type)type requestIds:(nullable NSString *)requestIds;
@end

NS_ASSUME_NONNULL_END
