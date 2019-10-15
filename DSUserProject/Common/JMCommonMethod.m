//
//  JMCommonMethod.m
//  JMBaseProject
//
//  Created by Liuny on 2018/8/23.
//  Copyright © 2018年 liuny. All rights reserved.
//

#import "JMCommonMethod.h"

@implementation JMCommonMethod
+(NSMutableAttributedString *)navigationTitleWithColor:(UIColor *)color title:(NSString *)title{
    NSMutableAttributedString *rtn = [[NSMutableAttributedString alloc] initWithString:title];
    UIFont *font = [UIFont boldSystemFontOfSize:19.0];
    [rtn addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, title.length)];
    [rtn addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, title.length)];
    return rtn;
}
+(void)navigationItemSet:(UIButton *)item fontColor:(UIColor *)color{
    [item setTitleColor:color forState:UIControlStateNormal];
    item.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
}

+(NSMutableDictionary *)baseRequestParams{
    NSMutableDictionary *rtn = [[NSMutableDictionary alloc] init];
    NSString *sessionId = [JMProjectManager sharedJMProjectManager].loginUser.sessionId;
    [rtn setJsonValue:sessionId key:@"sessionId"];
   
    return rtn;
}

//网络请求图片
+(NSURL *)imageUrlWithPath:(NSString *)imagePath{
    NSURL *rtn;
    if(imagePath.length == 0){
        return rtn;
    }
    if(![imagePath hasPrefix:@"http"]){
        NSString *allPath = [ImageBaseUrl stringByAppendingPathComponent:imagePath];
        rtn = [NSURL URLWithString:allPath];
    }else{
        rtn = [NSURL URLWithString:imagePath];
    }
    return rtn;
}

+(NSString *)pinImagePath:(NSString *)path{
    NSString *rtn;
    if(path.length == 0){
        return @"";
    }
    if(![path hasPrefix:@"http"]){
        NSString *allPath = [ImageBaseUrl stringByAppendingPathComponent:path];
        rtn = allPath;
    }else{
        rtn = path;
    }
    return rtn;
}

+(void)shadowView:(UIView *)view{
    //阴影
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    view.layer.shadowOffset = CGSizeMake(0, 5);
    view.layer.shadowOpacity = 0.04;
    //    view.layer.shadowRadius = 5;
}

+(void)largeImagePreview:(NSArray <NSString *> *)sourceData currentIndex:(NSInteger)index {
    NSMutableArray *browserDataArr = [NSMutableArray array];
    for(NSString *imageStr in sourceData){
        YBImageBrowseCellData *data = [YBImageBrowseCellData new];
        data.url = [NSURL URLWithString:imageStr];
        //        data.thumbUrl =
        [browserDataArr addObject:data];
    }
    YBImageBrowser *browser = [YBImageBrowser new];
    [browser.defaultToolBar hideOperationButton];
    browser.dataSourceArray = browserDataArr;
    browser.currentIndex = index;
    [YBIBCopywriter shareCopywriter].type = YBIBCopywriterTypeSimplifiedChinese;
    [browser show];
}

//替换手机号码
+ (NSString  *)getTelephoneNumWith:(NSString *)phoneStr {
    //获取字符串中的电话号码
    NSString *regulaStr = @"\\d{3,4}[- ]?\\d{7,8}";
    __block  NSString *endStr = phoneStr;
    NSError *error;
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:regulaStr options:NSRegularExpressionCaseInsensitive error:&error];
    [regex enumerateMatchesInString:phoneStr options:NSMatchingReportProgress range:NSMakeRange(0, phoneStr.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
        NSString *numStr = [phoneStr substringWithRange:result.range];
        if ([self isPhoneNumber:numStr]) {
            endStr =  [endStr stringByReplacingOccurrencesOfString:numStr withString:@"***********"];
        }
        
    }];
    
    return endStr;
}

//判断字符串是否为手机号
+ (BOOL )isPhoneNumber:(NSString *)str {
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSString * CM = @"^1(34[0-8]|3[5-9]|47|5[0127-9]|8[23478]|98)\\d{8}$";
    NSString * CU = @"^1((3[0-2]|45|5[56]|166|7[56]|8[56]))\\d{8}$";
    NSString * CT = @"^1((33|49|53|7[37]|8[019]|9[19]))\\d{8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    BOOL res1 = [regextestmobile evaluateWithObject:str];
    BOOL res2 = [regextestcm evaluateWithObject:str];
    BOOL res3 = [regextestcu evaluateWithObject:str];
    BOOL res4 = [regextestct evaluateWithObject:str];
    
    if (res1 || res2 || res3 || res4 ) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - 点赞动画
+(void)praiseAnimation:(UIView *)view coordinate:(CGRect)coordinate{
    UIImageView *imageView = [[UIImageView alloc] init];
    CGRect frame = view.frame;
    //  初始frame，即设置了动画的起点
    imageView.frame = CGRectMake(coordinate.origin.x, coordinate.origin.y - 25, 30, 30);
    //  初始化imageView透明度为0
    imageView.alpha = 0;
    imageView.backgroundColor = [UIColor clearColor];
    imageView.clipsToBounds = YES;
    //  用0.2秒的时间将imageView的透明度变成1.0，同时将其放大1.3倍，再缩放至1.1倍，这里参数根据需求设置
    [UIView animateWithDuration:0.2 animations:^{
        imageView.alpha = 1.0;
        imageView.frame = CGRectMake(coordinate.origin.x, coordinate.origin.y - 35, 30, 30);
        CGAffineTransform transfrom = CGAffineTransformMakeScale(1.3, 1.3);
        imageView.transform = CGAffineTransformScale(transfrom, 1, 1);
    }];
    
    [view addSubview:imageView];
    //  随机产生一个动画结束点的X值
    CGFloat finishX = frame.size.width - round(random() % 200);
    //  动画结束点的Y值
    CGFloat finishY = 200;
    //  imageView在运动过程中的缩放比例
    CGFloat scale = round(random() % 2) + 0.7;
    // 生成一个作为速度参数的随机数
    CGFloat speed = 1 / round(random() % 900) + 0.6;
    //  动画执行时间
    NSTimeInterval duration = 4 * speed;
    //  如果得到的时间是无穷大，就重新附一个值（这里要特别注意，请看下面的特别提醒）
    if (duration == INFINITY) duration = 2.412346;
    // 随机生成一个0~7的数，以便下面拼接图片名
    int imageName = round(random() % 5);
    
    //  开始动画
    [UIView beginAnimations:nil context:(__bridge void *_Nullable)(imageView)];
    //  设置动画时间
    [UIView setAnimationDuration:duration];
    //    int x = arc4random() % 5;
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"effect_icon_0%d", imageName]];
    //  拼接图片名字
    imageView.image = image;
    
    //  设置imageView的结束frame
    imageView.frame = CGRectMake( finishX, finishY, 30 * scale, 30 * scale);
    
    //  设置渐渐消失的效果，这里的时间最好和动画时间一致
    [UIView animateWithDuration:duration animations:^{
        imageView.alpha = 0;
    }];
    
    //  结束动画，调用onAnimationComplete:finished:context:函数
    [UIView setAnimationDidStopSelector:@selector(onAnimationComplete:finished:context:)];
    //  设置动画代理
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
}

/// 动画完后销毁iamgeView
- (void)onAnimationComplete:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context{
    UIImageView *imageView = (__bridge UIImageView *)(context);
    [imageView removeFromSuperview];
    imageView = nil;
}

@end
