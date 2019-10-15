//
//  MarketShopCell.h
//  JMBaseProject
//
//  Created by Liuny on 2019/6/19.
//  Copyright © 2019 liuny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MarketShopCellDelegate <NSObject>

-(void)didResale:(NSInteger)index;
-(void)didStore:(NSInteger)index;

@end

@interface MarketShopCell : UICollectionViewCell
@property(nonatomic, weak) id<MarketShopCellDelegate>delegate;
@property(nonatomic, assign) NSInteger index;
@property(nonatomic, strong) GoodModel *cellData;
@end

NS_ASSUME_NONNULL_END
