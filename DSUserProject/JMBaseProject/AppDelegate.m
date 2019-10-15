//
//  AppDelegate.m
//  JMBaseProject
//
//  Created by liuny on 2018/7/14.
//  Copyright © 2018年 liuny. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "LoginViewController.h"
#import "JMThirdPayHelper.h"
#import "AppDelegate+RemoteNotification.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //初始化第三方登录和分享
    [JMUMengHelper UMSocialStart];
    [[JMThirdPayHelper sharedJMThirdPayHelper] start];
    //腾讯云
    [TXLiveBase setLicenceURL:@"http://license.vod2.myqcloud.com/license/v1/fa92da162fc9490d2450df35caafb4c0/TXLiveSDK.licence" key:@"6c131ede22162322785f9de75fddd9b8"];
    [[JMProjectManager sharedJMProjectManager] loadRootVC];
    //七鱼客服
     [[QYSDK sharedSDK] registerAppId:@"b2cf38903857dee059aa007ac5783e10" appName:@"容妍珠宝"];
    [[IQKeyboardManager sharedManager].disabledDistanceHandlingClasses addObject:[QiYuCustomServiceController class]];
    
    [self registerRemoteNotification];
    
    return YES;
}

-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
     [[JMThirdPayHelper sharedJMThirdPayHelper] handleOpenURL:url];
    return result;
}

// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    [[JMThirdPayHelper sharedJMThirdPayHelper] handleOpenURL:url];
    return result;
}

/*
- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray<id<UIUserActivityRestoring>> * __nullable restorableObjects))restorationHandler {
return [WXApi handleOpenUniversalLink:userActivity
delegate:self];
}
 */


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
