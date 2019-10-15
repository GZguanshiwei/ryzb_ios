//
//  TCMsgModel.h
//  JMBaseProject
//
//  Created by Liuny on 2019/7/9.
//  Copyright © 2019 liuny. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, TCMsgModelType) {
    TCMsgModelType_NormalMsg           = 1,   //普通消息
    TCMsgModelType_MemberEnterRoom     = 2,   //进入房间消息
    TCMsgModelType_MemberQuitRoom      = 3,   //退出房间消息
    TCMsgModelType_Praise              = 4,   //点赞消息
    TCMsgModelType_DanmaMsg            = 5,   //弹幕消息
    TCMsgModelType_Paying              = 6,   //支付中消息
    TCMsgModelType_PaySuccess          = 7,   //支付成功消息
    TCMsgModelType_AnchorMsg           = 8,   //主播消息
    TCMsgModelType_Focus0nMsg          = 9,   //关注消息
    TCMsgModelType_HappyNews           = 10,  //喜报
    TCMsgModelType_Gift                = 11,  //赠送礼物
};

@interface TCMsgModel : NSObject
@property (nonatomic, assign) TCMsgModelType msgType;      //消息类型
@property (nonatomic, retain) NSString *userId;            //用户Id
@property (nonatomic, retain) NSString *userName;          //用户名字
@property (nonatomic, retain) NSString *liveGrade;         //直播间铁值等级
@property (nonatomic, retain) NSString *vipGrade;          //vip等级
@property (nonatomic, retain) NSString *userMsg;           //用户发的消息
@property (nonatomic, retain) NSString *userHeadImageUrl;  //用户头像url
@property (nonatomic, assign) NSInteger msgHeight;         //消息高度
@property (nonatomic, retain) NSAttributedString* msgAttribText;
@end

NS_ASSUME_NONNULL_END
