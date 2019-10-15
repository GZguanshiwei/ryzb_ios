//
//  RegularExp.m
//  iSalesOA
//
//  Created by 赵 莲锋 on 13-7-10.
//  Copyright (c) 2013年 赵 莲锋. All rights reserved.
//

#import "RegularExp.h"

@implementation RegularExp

+(BOOL)isValidateABC123:(NSString *)text;
{
    NSString *textRegex = @"^[A-Za-z0-9]+$";
    NSPredicate *textTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",textRegex];
    return [textTest evaluateWithObject:text];
}

/*汉字验证 MODIFIED BY HELENSONG*/
+(BOOL)isValidateRealName:(NSString *)name
{
    NSString *alph = @"^[\u4E00-\u9FA5]+$";
    NSPredicate *realNameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", alph];
    
    return [realNameTest evaluateWithObject:name];
}

/*邮箱验证 MODIFIED BY HELENSONG*/
+(BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

/**
 国际号码验证

 @param mobileNumbel 要验证的号码
 @return YES通过  NO不通过
 */
+ (BOOL) isMobileGuoJi:(NSString *)mobileNumbel{
    
    NSString *aaa = @"^\\s*\\+?\\s*(\\(\\s*\\d+\\s*\\)|\\d+)(\\s*-?\\s*(\\(\\s*\\d+\\s*\\)|\\s*\\d+\\s*))*\\s*$";
    
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", aaa];
    if (([regextestct evaluateWithObject:mobileNumbel]
         )) {
        return YES;
    }
    return NO;
}

/*手机号码验证 MODIFIED BY HELENSONG*/
+(BOOL)isValidateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符，2015年11月最新：^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$
    NSString *phoneRegex = @"^(0|86|17951)?(13[0-9]|15[012356789]|17[5678]|18[0-9]|14[57])[0-9]{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    NSLog(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:mobile];
}
/*车牌号验证 MODIFIED BY HELENSONG*/
+(BOOL)validateCarNo:(NSString *)carNo
{
    NSString *carRegex = @"^[A-Za-z]{1}[A-Za-z_0-9]{5}$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
//    NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:carNo];
}

/*数字验证(只能输入数字)*/
+(BOOL)isValidateNum:(NSString *)number
{
    NSString *numRegex = @"^[0-9]*$";
    NSPredicate *numTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",numRegex];
    return [numTest evaluateWithObject:number];
}

/*用户名验证*/
+(BOOL)isValidateLoginNum:(NSString *)loginNum{
    NSString *num = @"^[A-Z][A-Z0-9_]{0,19}$";
    NSPredicate *numTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",num];
//    NSLog(@"loginNum is %@",numTest);
    return [numTest evaluateWithObject:loginNum];
}

/*密码验证*/
+(BOOL)isValidatePassword:(NSString *)passWord{
    NSString *word = @"";
    NSPredicate *wordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",word];
    return [wordTest evaluateWithObject:passWord];
}

//身份证号
+ (BOOL) isValidateCardID: (NSString *)cardID
{
    BOOL flag;
    if (cardID.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:cardID];
}

/*
//身份证号码验证
+(BOOL)isValidateCardID:(NSString *)cardID
{
    //15位判断
    NSString *str15 = @"/^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$/";
    NSPredicate *test15 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",str15];
    BOOL flag15 = [test15 evaluateWithObject:cardID];
    
    //18位判断
    NSString *str18 = @"/^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{4}$/";
    NSPredicate *test18 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",str18];
    BOOL flag18 = [test18 evaluateWithObject:cardID];
    return (flag15 || flag18);
}
*/
 
/*验证联通号码*/
+(BOOL)isValidateUnionNumber:(NSString *)number{
//    NSString *num = @"^1(3[0-2]|4[5]|5[56]|8[56])\\d{8}$";
    NSString *num = @"^(?:13[0-2]|145|15[56]|176|18[56])\\d{8}$";
    NSPredicate *numTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",num];
    return [numTest evaluateWithObject:number];
}

/*大写字母验证*/
+(BOOL)isValidateUpAlphabet:(NSString *)alphabet{
    NSString *alph = @"[A-Z]";
    NSPredicate *alphTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",alph];
    return [alphTest evaluateWithObject:alphabet];
}

/*小写字母验证*/
+(BOOL)isValidateLowAlphabet:(NSString *)alphabet{
    NSString *alph = @"[a-z]";
    NSPredicate *alphTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",alph];
    return [alphTest evaluateWithObject:alphabet];
}

/*数字验证*/
+(BOOL)isvalidateNumber:(NSString *)number{
    NSString *numRegex = @"[0-9]";
    NSPredicate *numTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",numRegex];
    return [numTest evaluateWithObject:number];
}

/*特殊符号验证*/
+(BOOL)isValidateSymbol:(NSString *)symbol{
    NSString *sym = @"[^a-zA-Z0-9]";
    NSPredicate *symTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",sym];
    return [symTest evaluateWithObject:symbol];
}

@end
