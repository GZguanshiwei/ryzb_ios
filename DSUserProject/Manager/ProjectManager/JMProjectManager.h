//
//  JMProjectManager.h
//  JMBaseProject
//
//  Created by liuny on 2018/7/14.
//  Copyright © 2018年 liuny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JMLoginUserModel.h"

@interface JMProjectManager : NSObject
singleton_interface(JMProjectManager)
@property (nonatomic, strong) JMLoginUserModel *loginUser;

-(BOOL)isTourist;

//登录
-(void)loginWithParams:(NSDictionary *)params successBlock:(void(^)(void))successBlock failBlock:(void(^)(NSString *errorMsg))failBlock;
//第三方登录
-(void)thirdLoginWithType:(UMSocialPlatformType)type successBlock:(void(^)(void))successBlock failBlock:(void(^)(NSString *errorMsg))failBlock;
//登出
-(void)logoutWithSuccessBlock:(void(^)(void))successBlock failBlock:(void(^)(NSString *errorMsg))failBlock;
//获取登录用户详情
-(void)updateLoginUserInfoSuccessBlock:(void(^)(void))successBlock failBlock:(void(^)(NSString *errorMsg))failBlock;

-(void)loadRootVC;
-(void)showLoginViewController;
-(void)showMainViewController;

-(void)versionCheck:(BOOL)showAlert;

//全屏播放视频
-(void)fullScreenPlayVideo:(NSString *)videoUrl title:(NSString *)title coverImage:(NSString *)imageUrl;


-(void)enterRoom:(NSString *)roomId;
-(void)exitRoom:(NSString *)roomId;
-(void)closeEnterError:(NSString *)roomId;
-(void)liveSmallPlay:(NSString *)roomId;
-(void)liveLargePlay:(NSString *)roomId;
@end
