//
//  TagModel.h
//  JMBaseProject
//
//  Created by Liuny on 2018/11/9.
//  Copyright © 2018 liuny. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TagModel : NSObject
@property (nonatomic, assign) BOOL isSelect;
@property (nonatomic, strong) NSString *tagText;
@property (nonatomic, strong) NSString *tagId;

-(instancetype)initWithDictionary:(NSDictionary *)dict;

-(instancetype)initWithTagText:(NSString *)text;
@end

NS_ASSUME_NONNULL_END
