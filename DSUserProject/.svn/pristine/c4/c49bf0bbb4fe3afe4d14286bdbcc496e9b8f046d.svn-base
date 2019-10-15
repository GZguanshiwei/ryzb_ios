//
//  QRCode.m
//  JMBaseProject
//
//  Created by 抽筋的灯 on 2019/4/10.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "QRCode.h"

#define QRNormalRGB @"#000000"

@implementation QRCode

/**
 生成二维码图片
 
 @param content   二维码内容
 @param size      尺寸 传0为默认尺寸
 @return 返回生成的图片
 */
+ (UIImage *)generateImageWithQrCode:(NSString *)content QrCodeImageSize:(CGFloat)size
{
    return [self generateImageWithQrCode:content QrCodeImageSize:size RGB:QRNormalRGB backgroundImage:nil insertImage:nil radius:0];;
}

/**
 生成自定义颜色二维码
 
 @param content   二维码内容
 @param size      尺寸 传0为默认尺寸
 @param rgbValue  色值 例如：#ee68ba
 @return 二维码图片
 */
+ (UIImage *)generateImageWithQrCode:(NSString *)content QrCodeImageSize:(CGFloat)size RGB:(NSString *)rgbValue
{
    return [self generateImageWithQrCode:content QrCodeImageSize:size RGB:rgbValue backgroundImage:nil insertImage:nil radius:0];
}

/**
 二维码添加背景图
 
 @param content         二维码内容
 @param size            尺寸 传0为默认尺寸
 @param backgroundImage 背景图
 @return 二维码图片
 */
+ (UIImage *)generateImageWithQrCode:(NSString *)content QrCodeImageSize:(CGFloat)size backgroundImage:(UIImage *)backgroundImage
{
    return [self generateImageWithQrCode:content QrCodeImageSize:size RGB:QRNormalRGB backgroundImage:backgroundImage insertImage:nil radius:0];
}

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
                              radius:(CGFloat)radius
{
    return [self generateImageWithQrCode:content QrCodeImageSize:size RGB:QRNormalRGB backgroundImage:nil insertImage:insertImage radius:radius];
}

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
                              radius:(CGFloat)radius
{
    return [self generateImageWithQrCode:content QrCodeImageSize:size RGB:rgbValue backgroundImage:nil insertImage:insertImage radius:radius];
}

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
                              radius:(CGFloat)radius
{
    if (JMIsEmpty(content)) {
        return nil;
    }
    
    // 检查二维码尺寸是否符合规定
    CGFloat codeSize = [self checkQrCodeImageSize:size];
    // 调整清晰度，使其更加清晰
    CIImage *image = [self drawQrCodeImageWithLink:content];
    //绘制二维码图片
    UIImage *originImage = [self adjustClarityImageFromCIImage:image size:size color:rgbValue];
    if(insertImage){
        // 图片添加到二维码中心
        originImage = [self imageInsertedImage:originImage insertImage:insertImage radius:radius];
    }
    if(backgroundImage){
        // 二维码添加背景图
        originImage = [self imageSetBackgroundImage:originImage backgroundImage:backgroundImage];
    }
    
    // 重置图片尺寸
    return [self resetImageSize:codeSize byImage:originImage];
}

/**
 *  检查二维码尺寸是否符合规定
 *
 *  @param size 尺寸
 */
+ (CGFloat)checkQrCodeImageSize:(CGFloat)size
{
    size = (size==0)?1024:size;
    size = MAX(200, size);
    return size;
}

/**
 *  绘制二维码图片
 *
 *  @param content 二维码链接
 */
+ (CIImage *)drawQrCodeImageWithLink: (NSString *)content
{
    //创建名为"CIQRCodeGenerator"的CIFilter
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    //将filter所有属性设置为默认值
    [filter setDefaults];
    
    //将所需尽心转为UTF8的数据，并设置给filter
    NSData *data = [content dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];
    
    //设置二维码的纠错水平，越高纠错水平越高，可以污损的范围越大
    /*
     * L: 7%
     * M: 15%
     * Q: 25%
     * H: 30%
     */
    [filter setValue:@"H" forKey:@"inputCorrectionLevel"];
    
    //拿到二维码图片，此时的图片不是很清晰，需要二次加工
    CIImage *outPutImage = [filter outputImage];
    
    return outPutImage;
}

/**
 调整二维码清晰度
 
 @param img   模糊的二维码图片
 @param size  二维码的宽高
 @return 清晰的二维码图片
 */
+ (UIImage *)adjustClarityImageFromCIImage:(CIImage *)img size:(CGFloat)size color:(NSString *)rgbValue
{
    //二维码的颜色
    UIColor *pointColor = [UIColor colorWithHexString:rgbValue];
    //背景颜色
    UIColor *backgroundColor = [UIColor whiteColor];
    CIFilter *colorFilter = [CIFilter filterWithName:@"CIFalseColor"
                                       keysAndValues:
                             @"inputImage", img,
                             @"inputColor0", [CIColor colorWithCGColor:pointColor.CGColor],
                             @"inputColor1", [CIColor colorWithCGColor:backgroundColor.CGColor],
                             nil];
    
    CIImage *qrImage = colorFilter.outputImage;
    
    //绘制
    CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:qrImage fromRect:qrImage.extent];
    
    CGSize imageSize = CGSizeMake(size, size);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 3.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage(context, CGContextGetClipBoundingBox(context), cgImage);
    UIImage *codeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGImageRelease(cgImage);
    
    return codeImage;
}


/**
 *  颜色变化
 */
void ProviderReleaseData(void * info, const void * data, size_t size) {
    free((void *)data);
}


/**
 修改二维码颜色
 
 @param image    二维码图片
 @param rgbValue 色值 例如：#ee68ba
 @return 修改颜色后的二维码图片
 */
+ (UIImage *)changeColorWithQRCodeImg:(UIImage *)image colorValue:(NSString *)rgbValue
{
    //色值转换
    NSMutableString *mutableRBGString = [NSMutableString stringWithString:rgbValue];
    // 转换成标准16进制数
    [mutableRBGString replaceCharactersInRange:[mutableRBGString rangeOfString:@"#" ] withString:@"0x"];
    // 十六进制字符串转成整形。
    long colorLong = strtoul([mutableRBGString cStringUsingEncoding:NSUTF8StringEncoding], 0, 16);
    // 通过位与方法获取三色值
    NSUInteger red = (colorLong & 0xFF0000 )>>16;
    NSUInteger green = (colorLong & 0x00FF00 )>>8;
    NSUInteger blue =  colorLong & 0x0000FF;
    
    
    int imageWidth = image.size.width;
    int imageHeight = image.size.height;
    size_t bytesPerRow = imageWidth * 4;
    uint32_t *rgbImageBuf = (uint32_t *)malloc(bytesPerRow * imageHeight);
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpaceRef, kCGBitmapByteOrder32Little|kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    //遍历像素, 改变像素点颜色
    int pixelNum = imageWidth * imageHeight;
    uint32_t *pCurPtr = rgbImageBuf;
    for (int i = 0; i<pixelNum; i++, pCurPtr++) {
        if ((*pCurPtr & 0xFFFFFF00) < 0x99999900) {
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[3] = red*255;
            ptr[2] = green*255;
            ptr[1] = blue*255;
        }else{
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[0] = 0;
        }
    }
    //取出图片
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, ProviderReleaseData);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpaceRef,
                                        kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider,
                                        NULL, true, kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProvider);
    UIImage *resultImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpaceRef);
    
    
    return resultImage;
}

/**
 *  图片添加到二维码中心
 *
 *  @param originImage 二维码原图
 *  @param insertImage 插入的图片
 *  @param radius      圆角角度
 *
 *  @return 返回处理后的图片
 */
+ (UIImage *)imageInsertedImage:(UIImage *)originImage
                    insertImage:(UIImage *)insertImage
                         radius:(CGFloat)radius
{
    if (!insertImage) {
        return originImage;
    }
    
    insertImage = [self generateRoundedCornersWithImage:insertImage size:insertImage.size radius:radius];
    UIImage * whiteBG = [self createImageWithColor:[UIColor whiteColor]];
    whiteBG = [self generateRoundedCornersWithImage:whiteBG size:whiteBG.size radius:radius];
    const CGFloat whiteSize = 2.f;
    CGSize brinkSize = CGSizeMake(originImage.size.width / 5, originImage.size.height / 5);
    CGFloat brinkX = (originImage.size.width - brinkSize.width) * 0.5;
    CGFloat brinkY = (originImage.size.height - brinkSize.height) * 0.5;
    CGSize imageSize = CGSizeMake(brinkSize.width - 2 * whiteSize, brinkSize.height - 2 * whiteSize);
    CGFloat imageX = brinkX + whiteSize;
    CGFloat imageY = brinkY + whiteSize;
    UIGraphicsBeginImageContext(originImage.size);
    [originImage drawInRect: (CGRect){ 0, 0, (originImage.size) }];
    [whiteBG drawInRect: (CGRect){ brinkX, brinkY, (brinkSize) }];
    [insertImage drawInRect: (CGRect){ imageX, imageY, (imageSize) }];
    UIImage * resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resultImage;
}


/**
 *  二维码添加背景图
 *
 *  @param originImage     原图
 *  @param backgroundImage 背景图
 *
 *  @return 返回处理后的图片
 */
+ (UIImage *)imageSetBackgroundImage:(UIImage *)originImage backgroundImage:(UIImage *)backgroundImage
{
    // size越大背景图与二维码的边距越大
    CGFloat whiteSize = 0.f;
    if (!backgroundImage) {
        backgroundImage = [self createImageWithColor:[UIColor whiteColor]];
        whiteSize = 0;
    };
    
    CGSize imageSize = CGSizeMake(backgroundImage.size.width - 2 * whiteSize, backgroundImage.size.height - 2 * whiteSize);
    CGFloat imageX = whiteSize;
    CGFloat imageY = whiteSize;
    UIGraphicsBeginImageContext(backgroundImage.size);
    [backgroundImage drawInRect: (CGRect){ 0, 0, (backgroundImage.size) }];
    [originImage drawInRect: (CGRect){ imageX, imageY, (imageSize) }];
    UIImage * resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resultImage;
}


/**
 *  重置图片尺寸
 */
+ (UIImage *)resetImageSize:(CGFloat)size byImage:(UIImage *)image
{
    if (!image) {
        return nil;
    }
    if (size == 1024) {
        return image;
    }
    
    CGSize imageSize = CGSizeMake(size, size);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 3.0);
    [image drawInRect: (CGRect){ 0, 0, (imageSize) }];
    UIImage * resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}


/**
 *  生成圆角图片
 *
 *  @param image  图片
 *  @param size   尺寸
 *  @param radius 角度
 *
 *  @return 图片
 */
+ (UIImage *)generateRoundedCornersWithImage:(UIImage *)image size:(CGSize)size radius:(CGFloat)radius
{
    if (!image) {
        return nil;
    }
    
    const CGFloat width = size.width;
    const CGFloat height = size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, width, height, 8, 4 * width, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGRect rect = CGRectMake(0, 0, width, height);
    CGContextBeginPath(context);
    addRoundRectToPath(context, rect, radius, image.CGImage);
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    UIImage * img = [UIImage imageWithCGImage: imageMasked];
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageMasked);
    
    return img;
}



/**
 *  给上下文添加圆角蒙版
 */
void addRoundRectToPath(CGContextRef context, CGRect rect, float radius, CGImageRef image)
{
    float width, height;
    if (radius == 0) {
        CGContextAddRect(context, rect);
        return;
    }
    
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    width = CGRectGetWidth(rect);
    height = CGRectGetHeight(rect);
    
    //裁剪路径
    CGContextMoveToPoint(context, width, height / 2);
    CGContextAddArcToPoint(context, width, height, width / 2, height, radius);
    CGContextAddArcToPoint(context, 0, height, 0, height / 2, radius);
    CGContextAddArcToPoint(context, 0, 0, width / 2, 0, radius);
    CGContextAddArcToPoint(context, width, 0, width, height / 2, radius);
    CGContextClosePath(context);
    CGContextClip(context);
    
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), image);
    CGContextRestoreGState(context);
}


/**
 颜色转换成图片
 
 @param color 颜色
 @return 图片
 */
+ (UIImage*)createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1024.0f, 1024.0f);
    UIGraphicsBeginImageContext(rect.size);CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

@end
