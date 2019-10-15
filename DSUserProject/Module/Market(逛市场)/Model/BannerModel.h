//
//  BannerModel.h
//  JMBaseProject
//
//  Created by Liuny on 2018/12/19.
//  Copyright © 2018 liuny. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BannerModel : NSObject
@property (nonatomic, copy) NSString *modelId;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, copy) NSString *type;//0无   1商品   2超链接 
@property (nonatomic, copy) NSString *goUrl;
@property (nonatomic, copy) NSString *ids;
-(instancetype)initWithDictionary:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
