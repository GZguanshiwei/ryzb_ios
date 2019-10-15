//
//  MyBargingRecordCell.m
//  JMBaseProject
//
//  Created by 潘传标 on 2019/9/6.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "MyBargingRecordCell.h"

@interface MyBargingRecordCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *downMoneyLabel;

@end

@implementation MyBargingRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    ViewRadius(self.headImageView, self.headImageView.mj_h/2.0);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellData:(BargainUserModel *)cellData{
    _cellData = cellData;
    [self.headImageView sd_setImageWithURL:[JMCommonMethod imageUrlWithPath:self.cellData.userHead]];
    self.nameLabel.text = self.cellData.userName;
    self.timeLabel.text = self.cellData.time;
    self.downMoneyLabel.text = self.cellData.downMoney;
}


@end
