//
//  MyExchangeListCell.m
//  JMBaseProject
//
//  Created by 潘传标 on 2019/9/6.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "MyExchangeListCell.h"

@interface MyExchangeListCell ()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UIButton *logisticsButton;
@property (weak, nonatomic) IBOutlet UIImageView *rightButton;
@end

@implementation MyExchangeListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    ViewRadius(self.coverImageView, 5);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellData:(IntegralExchangeModel *)cellData{
    _cellData = cellData;
    [self.coverImageView sd_setImageWithURL:[JMCommonMethod imageUrlWithPath:self.cellData.coverImage]];
    self.nameLabel.text = self.cellData.name;
    self.timeLabel.text = self.cellData.time;
    switch (self.cellData.type.intValue) {
        case 0:
            self.logisticsButton.hidden = NO;
            self.rightButton.hidden = NO;
            break;
        case 1:
            self.logisticsButton.hidden = YES;
            self.rightButton.hidden = YES;
            break;
        default:
            break;
    }
    
}

- (IBAction)wuliuButtonClick:(id)sender {
    if (self.logisticsButtonBlock) {
        self.logisticsButtonBlock();
    }
}

@end
