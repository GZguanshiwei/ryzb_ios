//
//  MyCouponListCell.m
//  JMBaseProject
//
//  Created by 潘传标 on 2019/9/6.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "MyCouponListCell.h"

@interface MyCouponListCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *instructionLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLevelLabel;


@end

@implementation MyCouponListCell

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
    self.nameLabel.text = self.cellData.name;
    self.instructionLabel.text = [self.cellData instructionsText];
    self.moneyLabel.text = [NSString stringWithFormat:@"￥%@",self.cellData.deductionPrice];
    self.endTimeLabel.text = [NSString stringWithFormat:@"有效期至%@",self.cellData.overTime];
    self.moneyLevelLabel.text = [NSString stringWithFormat:@"满%@可用",self.cellData.restrictPrice];
    
}

- (IBAction)buttonClick:(UIButton *)sender {
    if (self.buttonActionBlock) {
        self.buttonActionBlock(sender.tag);
    }
}

@end
