//
//  OrderCell.h
//  JMBaseProject
//
//  Created by Liuny on 2019/6/26.
//  Copyright © 2019 liuny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol OrderCellDelegate <NSObject>

-(void)clickOperationButton:(NSInteger)index title:(NSString *)buttonTitle;

@end

@interface OrderCell : UITableViewCell
@property (strong, nonatomic) OrderModel *cellData;
@property (strong, nonatomic) OrderModel *shopOrderData;


@property (assign, nonatomic) NSInteger index;
@property (weak, nonatomic) id<OrderCellDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
