//
//  LevelRecordModel.h
//  JMBaseProject
//
//  Created by Liuny on 2019/9/25.
//  Copyright © 2019 liuny. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LevelRecordModel : NSObject
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *value;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *image;

-(instancetype)initWithDictionary:(NSDictionary *)dict;
-(NSString *)iconImageName;
@end

NS_ASSUME_NONNULL_END
