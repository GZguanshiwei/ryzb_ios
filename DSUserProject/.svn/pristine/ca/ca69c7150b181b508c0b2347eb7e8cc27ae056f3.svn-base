//
//  JMUMengHelper.m
//  iOSProject
//
//  Created by HuXuPeng on 2017/12/29.
//  Copyright © 2017年 HuXuPeng. All rights reserved.
//

#import "JMUMengHelper.h"
#import "AppDelegate.h"

// 友盟
NSString *const UMConfigInstanceAppKey = @"58aa7d20e88bad08c1001dcd";
NSString *const UMConfigInstanceChannelId = @"App Store";
NSString *const UMSocialAppkey = @"58aa7d20e88bad08c1001dcd";
NSString *const UMessageStartWithAppkey = @"58aa7d20e88bad08c1001dcd";
NSString *const UMessageAppMasterSecret = @"ntljqfii29nachyuqpbmwl5u5yofkyk6";

// UM 微信
NSString *const WeChatAppKey = @"wx8c4996071131b549";
NSString *const WeChatAppSecret = @"5a5391b769fb1acbd57a7289c3ce4a3a";
NSString *const WeChatRedirectURL = @"http://mobile.umeng.com/social";

// UM QQ
NSString *const QQAppKey = @"101783934";
NSString *const QQAppSecret = @"a8b2cab1df81247249492cded0948647";
NSString *const QQRedirectURL = @"http://mobile.umeng.com/social";

//sina
NSString *const SinaAppKey = @"1131384369";
NSString *const SinaAppSecret = @"9578076f25022896b3e25cee9701630c";
NSString *const SinaRedirectURL = @"https://api.weibo.com/oauth2/default.html";

// 通知(分享成功)
NSString *const LMJUMSocialShareSucceedNotification = @"LMJUMSocialShareSucceedNotification";


@implementation JMUMengHelper
+ (void)UMAnalyticStart {
    // 友盟统计
    [UMConfigure initWithAppkey:UMConfigInstanceAppKey channel:UMConfigInstanceChannelId];
#ifdef DEBUG
    //打开调试日志
    [UMConfigure setLogEnabled:YES];
#endif
}

+ (void)UMSocialStart
{
    // 友盟分享
    [UMConfigure initWithAppkey:UMConfigInstanceAppKey channel:UMConfigInstanceChannelId];
    
    //设置微信的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WeChatAppKey appSecret:WeChatAppSecret redirectURL:WeChatRedirectURL];
    
    //设置分享到QQ互联的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQAppKey  appSecret:QQAppSecret redirectURL:QQRedirectURL];
    
    //设置新浪的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:SinaAppKey  appSecret:SinaAppSecret redirectURL:SinaRedirectURL];
    
    
#ifdef DEBUG
    //打开调试日志
    [UMConfigure setLogEnabled:YES];
#endif
}

#pragma mark - 分享
//网页分享自定义
+ (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType shareTitle:(NSString *)title subTitle:(NSString *)subTitle thumbImage:(id)thumbImage shareURL:(NSString *)shareURL
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:subTitle thumImage:thumbImage];
    
    //设置网页地址
    shareObject.webpageUrl = shareURL;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:nil completion:^(id data, NSError *error) {
        if (error) {
            JMLog(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                JMLog(@"response message is %@",resp.message);
                //第三方原始返回的数据
                JMLog(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                JMLog(@"response data is %@",data);
            }
            // 分享成功的通知
            [[NSNotificationCenter defaultCenter] postNotificationName:LMJUMSocialShareSucceedNotification object:shareURL];
        }
        [self alertWithError:error];
    }];
}


// 网页分享
+ (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    NSString* thumbURL =  @"https://mobile.umeng.com/images/pic/home/social/img-1.png";
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"欢迎使用【友盟+】社会化组件U-Share" descr:@"欢迎使用【友盟+】社会化组件U-Share，SDK包最小，集成成本最低，助力您的产品开发、运营与推广！" thumImage:thumbURL];
    //设置网页地址
    shareObject.webpageUrl = @"http://mobile.umeng.com/social";
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        
        [self alertWithError:error];
        
    }];
}

// 分享文本
+ (void)shareTextToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //设置文本
    messageObject.text = @"社会化组件UShare将各大社交平台接入您的应用，快速武装App。";
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            JMLog(@"************Share fail with error %@*********",error);
        }else{
            JMLog(@"response data is %@",data);
        }
    }];
}


// 分享图片
+ (void)shareImageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建图片内容对象
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    //如果有缩略图，则设置缩略图
    shareObject.thumbImage = [UIImage imageNamed:@"icon"];
    [shareObject setShareImage:@"https://mobile.umeng.com/images/pic/home/social/img-1.png"];
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            JMLog(@"************Share fail with error %@*********",error);
        }else{
            JMLog(@"response data is %@",data);
        }
    }];
}

// 分享音乐
+ (void)shareMusicToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建音乐内容对象
    UMShareMusicObject *shareObject = [UMShareMusicObject shareObjectWithTitle:@"分享标题" descr:@"分享内容描述" thumImage:[UIImage imageNamed:@"icon"]];
    //设置音乐网页播放地址
    shareObject.musicUrl = @"http://c.y.qq.com/v8/playsong.html?songid=108782194&source=yqq#wechat_redirect";
    //            shareObject.musicDataUrl = @"这里设置音乐数据流地址（如果有的话，而且也要看所分享的平台支不支持）";
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            JMLog(@"************Share fail with error %@*********",error);
        }else{
            JMLog(@"response data is %@",data);
        }
    }];
}


// 分享视频
+ (void)shareVedioToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建视频内容对象
    UMShareVideoObject *shareObject = [UMShareVideoObject shareObjectWithTitle:@"分享标题" descr:@"分享内容描述" thumImage:[UIImage imageNamed:@"icon"]];
    //设置视频网页播放地址
    shareObject.videoUrl = @"http://video.sina.com.cn/p/sports/cba/v/2013-10-22/144463050817.html";
    //            shareObject.videoStreamUrl = @"这里设置视频数据流地址（如果有的话，而且也要看所分享的平台支不支持）";
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            JMLog(@"************Share fail with error %@*********",error);
        }else{
            JMLog(@"response data is %@",data);
        }
    }];
}



#pragma mark - alert
+ (void)alertWithError:(NSError *)error
{
    /*TODO
    [UIAlertController mj_showAlertWithTitle:error ? @"分享失败" : @"分享成功" message:nil appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
        alertMaker.toastStyleDuration = 2;
        
    } actionsBlock:nil];
     */
}



#pragma mark - 第三方登录
+ (void)getUserInfoForPlatform:(UMSocialPlatformType)platformType completion:(void(^)(UMSocialUserInfoResponse *result, NSError *error))completion
{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:platformType currentViewController:nil completion:^(id result, NSError *error) {
        
        UMSocialUserInfoResponse *resp = result;
        
        // 第三方登录数据(为空表示平台未提供)
        // 授权数据
        JMLog(@" uid: %@", resp.uid);
        JMLog(@" openid: %@", resp.openid);
        JMLog(@" accessToken: %@", resp.accessToken);
        JMLog(@" refreshToken: %@", resp.refreshToken);
        JMLog(@" expiration: %@", resp.expiration);
        
        // 用户数据
        JMLog(@" name: %@", resp.name);
        JMLog(@" iconurl: %@", resp.iconurl);
        JMLog(@" gender: %@", resp.gender);
        
        // 第三方平台SDK原始数据
        JMLog(@" originalResponse: %@", resp.originalResponse);
        
        completion(resp, error);
        
    }];
}



#pragma mark - 统计
+ (void)beginLogPageView:(__unsafe_unretained Class)pageView {
    [MobClick beginLogPageView:NSStringFromClass(pageView)];
}

+ (void)endLogPageView:(__unsafe_unretained Class)pageView {
    [MobClick endLogPageView:NSStringFromClass(pageView)];
}

+(void)beginLogPageViewName:(NSString *)pageViewName
{
    [MobClick beginLogPageView:pageViewName];
}

+(void)endLogPageViewName:(NSString *)pageViewName
{
    [MobClick endLogPageView:pageViewName];
}

@end
