//
//  StoreCell.h
//  JMBaseProject
//
//  Created by Liuny on 2019/6/19.
//  Copyright © 2019 liuny. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol StoreCellDelegate <NSObject>

-(void)didCancelStore:(NSIndexPath *)indexPath;
-(void)didBuy:(NSIndexPath *)indexPath;
-(void)didCustomerService:(NSIndexPath *)indexPath;
@end

@interface StoreCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *tagView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) id<StoreCellDelegate>delegate;
@property (strong, nonatomic) NSIndexPath *indexPath;
@property (strong, nonatomic) GoodModel *storeGood;

@end

NS_ASSUME_NONNULL_END
