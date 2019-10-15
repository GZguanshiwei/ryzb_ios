//
//  QRCode.h
//  JMBaseProject
//
//  Created by 抽筋的灯 on 2019/4/10.
//  Copyright © 2019 liuny. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QRCode : NSObject

/**
 生成二维码图片
 
 @param content   二维码内容
 @param size      尺寸 传0为默认尺寸
 @return 返回生成的图片
 */
+ (UIImage *)generateImageWithQrCode:(NSString *)content
                     QrCodeImageSize:(CGFloat)size;


/**
 生成自定义颜色二维码
 
 @param content  二维码内容
 @param size     尺寸 传0为默认尺寸
 @param rgbValue 色值 例如：#ee68ba
 @return 二维码图片
 */
+ (UIImage *)generateImageWithQrCode:(NSString *)content
                     QrCodeImageSize:(CGFloat)size
                                 RGB:(NSString *)rgbValue;


/**
 二维码添加背景图
 
 @param content         二维码内容
 @param size            尺寸 传0为默认尺寸
 @param backgroundImage 背景图
 @return 二维码图片
 */
+ (UIImage *)generateImageWithQrCode:(NSString *)content
                     QrCodeImageSize:(CGFloat)size
                     backgroundImage:(UIImage *)backgroundImage;

/**
 中心插入图片
 
 @param content     二维码内容
 @param size        尺寸 传0为默认尺寸
 @param insertImage 插入的图片
 @param radius      圆角
 @return 二维码图片
 */
+ (UIImage *)generateImageWithQrCode:(NSString *)content
                     QrCodeImageSize:(CGFloat)size
                         insertImage:(UIImage *)insertImage
                              radius:(CGFloat)radius;


/**
 中心插入图片并修改二维码颜色
 
 @param content     二维码内容
 @param size        尺寸 传0为默认尺寸
 @param insertImage 插入的图片
 @param radius      圆角
 @return 二维码图片
 */
+ (UIImage *)generateImageWithQrCode:(NSString *)content
                     QrCodeImageSize:(CGFloat)size
                                 RGB:(NSString *)rgbValue
                         insertImage:(UIImage *)insertImage
                              radius:(CGFloat)radius;



/**
 生成自定义颜色并且添加背景图和中心插入图片的二维码图片
 
 @param content          二维码内容
 @param size             尺寸 传0为默认尺寸
 @param rgbValue         色值 例如：#ee68ba
 @param backgroundImage  背景图
 @param insertImage      插入的图片
 @param radius           圆角
 @return 二维码图片
 */
+ (UIImage *)generateImageWithQrCode:(NSString *)content
                     QrCodeImageSize:(CGFloat)size
                                 RGB:(NSString *)rgbValue
                     backgroundImage:(UIImage *)backgroundImage
                         insertImage:(UIImage *)insertImage
                              radius:(CGFloat)radius;

@end

NS_ASSUME_NONNULL_END
