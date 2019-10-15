//
//  MarketShopHeader.h
//  JMBaseProject
//
//  Created by Liuny on 2019/6/19.
//  Copyright © 2019 liuny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TagModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MarketShopHeaderDelegate <NSObject>

-(void)didShowAllType;
-(void)didChangeType:(NSInteger)index;

@end

@interface MarketShopHeader : UICollectionReusableView

@property (strong, nonatomic) NSMutableArray *typesArray;
@property (weak, nonatomic) id<MarketShopHeaderDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
