//
//  DetailsStatusCell.m
//  JMBaseProject
//
//  Created by Liuny on 2019/6/26.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "DetailsStatusCell.h"

@interface DetailsStatusCell ()
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *pointLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@end

@implementation DetailsStatusCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellData:(WalletRecordModel *)cellData{
    _cellData = cellData;
    self.contentLabel.text = @"提现（含手续费）";
    self.timeLabel.text = self.cellData.time;
    self.pointLabel.text = self.cellData.amount;
    self.statusLabel.text = @"审核中";
}

@end
