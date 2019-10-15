//
//  WalletChoiceCashListCell.m
//  JMBaseProject
//
//  Created by 潘传标 on 2019/9/7.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "WalletChoiceCashListCell.h"

@interface WalletChoiceCashListCell ()

@property (strong, nonatomic) IBOutlet UIImageView *coverImageView;
@property (strong, nonatomic) IBOutlet UILabel *accountLabel;


@end

@implementation WalletChoiceCashListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setCellData:(WalletAccountListModel *)cellData {
    _cellData = cellData;
    //账号
    self.accountLabel.text = cellData.account;
    //提现方式1银行卡2微信3支付宝
    switch (cellData.type.intValue) {
        case 1:
            self.coverImageView.image = [UIImage imageNamed:@"txzh_icon_bank"];
            break;
        case 2:
            self.coverImageView.image = [UIImage imageNamed:@"txzh_icon_wechat"];
            break;
        case 3:
            self.coverImageView.image = [UIImage imageNamed:@"txzh_icon_alipay"];
            break;
        default:
            break;
    }
}

- (IBAction)selectButtonClick:(id)sender {
    UIButton *selectButton = (UIButton *)sender;
    selectButton.selected = !selectButton.selected;
    if (self.selectButtonBlock) {
        self.selectButtonBlock();
    }
}

- (IBAction)deleteButtonClick:(id)sender {
    if (self.deleteButtonBlock) {
        self.deleteButtonBlock();
    }
}

@end
