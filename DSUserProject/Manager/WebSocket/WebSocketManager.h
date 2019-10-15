//
//  WebSocketManager.h
//  JMBaseProject
//
//  Created by Liuny on 2018/12/15.
//  Copyright © 2018 liuny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SocketRocket.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    HXSocketStatusConnecting,      // 正在连接
    HXSocketStatusConnected,       // 已连接
    HXSocketStatusFailed,          // 失败
    HXSocketStatusClosedByServer,  // 系统关闭
    HXSocketStatusClosedByUser,    // 用户关闭
    HXSocketStatusReceived,        // 接收消息
} HXSocketStatus;

@interface WebSocketManager : NSObject
/**
 重连时间间隔，默认3秒钟
 */
@property(nonatomic, assign) NSTimeInterval overtime;

/**
 重连次数，默认无限次 -- NSUIntegerMax
 */
@property(nonatomic, assign) NSUInteger reconnectCount;

/**
 当前链接状态
 */
@property(nonatomic, assign) HXSocketStatus status;

+ (instancetype)sharedInstance;

/**
 开始连接
 */
- (void)connect;

/**
 关闭连接
 */
- (void)close;

/**
 发送一条消息
 
 @param message 消息体
 */
- (void)sendMessage:(NSString *)message;


-(void)sendLogout;

@end

NS_ASSUME_NONNULL_END
