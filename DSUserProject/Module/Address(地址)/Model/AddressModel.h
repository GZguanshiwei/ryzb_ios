//
//  AddressModel.h
//  JMBaseProject
//
//  Created by Liuny on 2018/12/28.
//  Copyright © 2018 liuny. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddressModel : NSObject
@property (nonatomic, copy) NSString *addressId;//id
@property (nonatomic, assign) BOOL isDefault;//是否是默认的

@property (nonatomic, copy) NSString *sheng;//省
@property (nonatomic, copy) NSString *shi;//市
@property (nonatomic, copy) NSString *qu;//区
@property (nonatomic, copy) NSString *address;//详细地址

//购买商品时使用
@property (nonatomic, copy) NSString *name;//姓名
@property (nonatomic, copy) NSString *phone;//手机号码

@property (nonatomic, assign) BOOL isSelect;//是否选中

-(instancetype)initWithTest;
-(instancetype)initWithDictionary:(NSDictionary *)dict;

-(NSString *)allAddress;

@end

NS_ASSUME_NONNULL_END
