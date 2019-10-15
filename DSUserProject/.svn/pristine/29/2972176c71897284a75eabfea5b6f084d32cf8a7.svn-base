//
//  LiveHeader.h
//  JMBaseProject
//
//  Created by Liuny on 2019/6/28.
//  Copyright © 2019 liuny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TagModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol LiveHeaderDelegate <NSObject>

-(void)didShowAllType;
-(void)didShowAllAttention;
-(void)didEnterLiveRoom:(NSString *)roomId;
-(void)didChangeType:(NSInteger)index;

@end

@interface LiveHeader : UICollectionReusableView
@property (nonatomic, weak) id<LiveHeaderDelegate>delegate;
@property (strong, nonatomic) NSMutableArray *typesArray;
@end

NS_ASSUME_NONNULL_END
