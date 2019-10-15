//
//  JMCommonMethod.h
//  JMBaseProject
//
//  Created by Liuny on 2018/8/23.
//  Copyright © 2018年 liuny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JMCommonMethod : NSObject
//导航栏标题文字属性
+(NSMutableAttributedString *)navigationTitleWithColor:(UIColor *)color title:(NSString *)title;
//导航栏左右按钮文字属性
+(void)navigationItemSet:(UIButton *)item fontColor:(UIColor *)color;
//接口请求基础数据
+(NSMutableDictionary *)baseRequestParams;
//网络请求图片
+(NSURL *)imageUrlWithPath:(NSString *)imagePath;
+(NSString *)pinImagePath:(NSString *)path;
//阴影
+(void)shadowView:(UIView *)view;
+(void)largeImagePreview:(NSArray <NSString *> *)sourceData currentIndex:(NSInteger)index;
//替换手机号码
+ (NSString  *)getTelephoneNumWith:(NSString *)phoneStr;
//点赞动画
+(void)praiseAnimation:(UIView *)view coordinate:(CGRect)coordinate;
@end
