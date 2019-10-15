//
//  CouponListCell.m
//  JMBaseProject
//
//  Created by 潘传标 on 2019/9/5.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "CouponListCell.h"

@interface CouponListCell ()
@property (weak, nonatomic) IBOutlet UIImageView *leftBgImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rightBgImageView;
@property (weak, nonatomic) IBOutlet UIButton *selectButton;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *manMoneyLabel;
@end

@implementation CouponListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellData:(MyCouponModel *)cellData{
    _cellData = cellData;
    self.titleLabel.text = self.cellData.name;
    self.moneyLabel.text = [NSString stringWithFormat:@"￥%@",self.cellData.deductionPrice];
    self.manMoneyLabel.text = [NSString stringWithFormat:@"满%@可用",self.cellData.restrictPrice];
    self.timeLabel.text = [NSString stringWithFormat:@"有效期至%@",self.cellData.overTime];
    self.selectButton.selected = self.cellData.isSelect;
}

-(void)setCanUse:(BOOL)canUse{
    _canUse = canUse;
    if(self.canUse == YES){
        self.rightBgImageView.image = [UIImage imageNamed:@"home_pop_yhq_bg _02"];
        self.leftBgImageView.image = [UIImage imageNamed:@"home_pop_yhq_bg"];
        self.selectButton.enabled = YES;
    }else{
        self.rightBgImageView.image = [UIImage imageNamed:@"qrdd_pop03_yhq_unable_02"];
        self.leftBgImageView.image = [UIImage imageNamed:@"qrdd_pop03_yhq_unable_01"];
        self.selectButton.enabled = NO;
    }
}


@end
