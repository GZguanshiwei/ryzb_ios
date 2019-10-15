//
//  RegularExp.h
//  iSalesOA
//
//  Created by 赵 莲锋 on 13-7-10.
//  Copyright (c) 2013年 赵 莲锋. All rights reserved.
//

/*
 * 正则表达式验证
 */

#import <Foundation/Foundation.h>

@interface RegularExp : NSObject
//字母、数字
+(BOOL)isValidateABC123:(NSString *)text;

/*汉字验证 MODIFIED BY HELENSONG*/
+(BOOL)isValidateRealName:(NSString *)name;
/*邮箱验证 MODIFIED BY HELENSONG*/
+(BOOL)isValidateEmail:(NSString *)email;
/**
 国际号码验证
 
 @param mobileNumbel 要验证的号码
 @return YES通过  NO不通过
 */
+ (BOOL) isMobileGuoJi:(NSString *)mobileNumbel;
/*手机号码验证 MODIFIED BY HELENSONG*/
+(BOOL)isValidateMobile:(NSString *)mobile;

/*车牌号验证 MODIFIED BY HELENSONG*/
+(BOOL)validateCarNo:(NSString *)carNo;

//身份证号码验证
+(BOOL)isValidateCardID:(NSString *)cardID;

/*数字验证*/
+(BOOL)isValidateNum:(NSString *)number;

+(BOOL)isValidateLoginNum:(NSString *)loginNum;

/*密码验证*/
+(BOOL)isValidatePassword:(NSString *)passWord;

/*验证联通号码*/
+(BOOL)isValidateUnionNumber:(NSString *)number;

/*大写字母验证*/
+(BOOL)isValidateUpAlphabet:(NSString *)alphabet;

/*小写字母验证*/
+(BOOL)isValidateLowAlphabet:(NSString *)alphabet;

/*数字验证*/
+(BOOL)isvalidateNumber:(NSString *)number;

/*特殊符号验证*/
+(BOOL)isValidateSymbol:(NSString *)symbol;


@end
