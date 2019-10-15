//
//  JMCommonHeader.h
//  JMBaseProject
//
//  Created by liuny on 2018/7/14.
//  Copyright © 2018年 liuny. All rights reserved.
//

#ifndef JMCommonHeader_h
#define JMCommonHeader_h

#import "Singleton.h"
#import "JMHttpUrl.h"

/*
 *第三方库
 */
//基本框架
#import <AFNetworking.h>
#import <MBProgressHUD.h>
#import <MJRefresh.h>
#import <SDWebImage.h>
#import <Masonry.h>
#import <UITextView+Placeholder/UITextView+Placeholder.h>
#import <IQKeyboardManager.h>
#import <YYCategories.h>
#import <MJExtension/MJExtension.h>
#import <YBImageBrowser.h>
#import <YBIBCopywriter.h>
#import <TXLiteAVSDK.h>

/*
 *Base
 */
#import "JMTabBarController.h"
#import "JMNavigationController.h"
#import "JMBaseViewController.h"
#import "LoginViewController.h"

/*
 *分类（category）
 */
#import "NSDictionary+JMJson.h"
#import "NSMutableDictionary+JMJson.h"
#import "UIWindow+CurrentViewController.h"

/*
 *Help
 */
//友盟
#import "JMUMengHelper.h"
//文件处理相关
#import "JMFileManagerHelper.h"
//系统权限判断（相机、相册...）
#import "JMPermissionHelper.h"
//提示框、加载框
#import "JMProgressHelper.h"
//UIAlertController封装调用
#import "JXTAlertController.h"
//七鱼客服
# import <QYSDK.h>
#import "QiYuCustomServiceController.h"
/*
 *Tool
 */
//上拉、下拉封装
#import "JMRefreshTool.h"
//验证码
#import "JMPhoneCodeTool.h"
//拍照或选择图片
#import "JMPickPhotoTool.h"

/*
 *自定义manager
 */
#import "JMProjectManager.h"
#import "JMRequestManager.h"
#import "WebSocketManager.h"
#import "JMCommonMacro.h"
#import "ScreenCenterTipView.h"

#import "Address.h"
#import "CityHeader.h"
#import "HtmlViewController.h"
#import "ShareTipView.h"

#import "GoodModel.h"

#import "NewsViewController.h"

#endif /* JMCommonHeader_h */
