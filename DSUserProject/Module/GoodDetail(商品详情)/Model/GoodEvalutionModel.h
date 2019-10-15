//
//  GoodEvalutionModel.h
//  JMBaseProject
//
//  Created by Liuny on 2018/12/27.
//  Copyright © 2018 liuny. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface GoodEvalutionModel : NSObject
@property (nonatomic, copy) NSString *userHeadUrl;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *spec;
@property (nonatomic, copy) NSString *starLevel;
@property (nonatomic, strong) NSMutableArray *pictureArray;


-(instancetype)initWithGoodDetailDictionary:(NSDictionary *)dict;
-(instancetype)initWithEvalutionListDictionary:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
