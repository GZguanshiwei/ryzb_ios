//
//  JMCommonMacro.h
//  JMBaseProject
//
//  Created by liuny on 2018/7/14.
//  Copyright © 2018年 liuny. All rights reserved.
//

#ifndef JMCommonMacro_h
#define JMCommonMacro_h

#ifdef DEBUG
// 调试阶段
#define JMLog(...) NSLog(__VA_ARGS__)
#else
// 发布阶段
#define JMLog(...)
#endif

//是否是空对象
#define JMIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))

//属性转字符串
#define JMKeyPath(obj, key) @(((void)obj.key, #key))

//弱引用/强引用  可配对引用在外面用JMWeak(self)，block用MPStrongSelf(self)  也可以单独引用在外面用JMWeak(self) block里面用weakself
#define JMWeak(type)  __weak typeof(type) weak##type = type

#define kGetColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

// ——————— 颜色 ————————
//全局色调
#define kColorMain          [UIColor colorWithHexString:@"#53D1A3"]
//文本黑
#define kColorTextBlack     kGetColor(32.0,32.0,32.0)
//文本灰
#define kColorTextGray      kGetColor(102.0,102.0,102.0)
//分割线灰
#define kColorSeparator     kGetColor(228.0,228.0,228.0)
//背景灰
#define kColorBackgroundGray    kGetColor(247.0,247.0,247.0)
//边框线灰
#define kColorBorderGray     kGetColor(204.0,204.0,204.0)
//navigation tint color
#define kColorNavigationTint    [UIColor whiteColor]

// ——————— 字体 ————————
#define kFontSizeNavigation 18.0

//View 圆角和加边框
#define ViewBorderRadius(View, Radius, BorderWidth, BorderColor)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(BorderWidth)];\
[View.layer setBorderColor:[BorderColor CGColor]]
// View 圆角
#define ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]

// 判断是否为iPhone X 系列  这样写消除了在Xcode10上的警告。
#define XP_iPhoneX \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

// Status bar height.
#define  XP_StatusBarHeight      (XP_iPhoneX ? 44.f : 20.f)
// Navigation bar height.
#define  XP_NavigationBarHeight  44.f
// Tabbar height.
#define  XP_TabbarHeight         (XP_iPhoneX ? (49.f+34.f) : 49.f)
// Status bar & navigation bar height.
#define  XP_StatusBarAndNavigationBarHeight  (XP_iPhoneX ? 88.f : 64.f)

// ——————— 数据处理宏定义 ————————
#define kResponseNoData  @"服务器无数据返回"
#define kResponseLogout  @"用户尚未登录"
#define kResponseEmpty   @"返回数据为空"
#define kRequestFailure  @"网络请求异常，请检查网络"
#define kDisconnect      @"与服务器断开连接，请重连"

typedef enum{
    Sex_Female = 0,     //女
    Sex_Male,           //男
    Sex_Secrecy,        //保密
} Sex_E;
#endif /* JMCommonMacro_h */
