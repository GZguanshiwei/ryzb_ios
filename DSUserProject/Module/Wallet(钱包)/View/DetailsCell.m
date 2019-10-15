//
//  DetailsCell.m
//  JMBaseProject
//
//  Created by Liuny on 2019/6/26.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "DetailsCell.h"

@interface DetailsCell ()
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *pointLabel;

@end

@implementation DetailsCell

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
    NSString *content = @"";
    switch (self.cellData.type.integerValue) {
        case 1:
            content = @"邀请返利";
            break;
        case 2:
            content = @"提现（含手续费）";
            break;
        case 3:
            content = @"提现失败（含手续费）";
            break;
        default:
            break;
    }
    self.contentLabel.text = content;
    self.timeLabel.text = self.cellData.time;
    self.pointLabel.text = self.cellData.amount;
}

@end
