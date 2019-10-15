//
//  WalletChoiceCashListCell.h
//  JMBaseProject
//
//  Created by 潘传标 on 2019/9/7.
//  Copyright © 2019 liuny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WalletAccountListModel.h"

NS_ASSUME_NONNULL_BEGIN
static NSString *walletChoiceCashListCellID = @"WalletChoiceCashListCellID";
@interface WalletChoiceCashListCell : UITableViewCell

@property (nonatomic, strong) WalletAccountListModel *cellData;

@property(nonatomic,copy)void(^deleteButtonBlock)(void);
@property(nonatomic,copy)void(^selectButtonBlock)(void);
@property (weak, nonatomic) IBOutlet UIButton *selectButton;
@end

NS_ASSUME_NONNULL_END
