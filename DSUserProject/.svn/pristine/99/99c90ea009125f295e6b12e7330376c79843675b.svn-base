//
//  IntegraMallListCell.m
//  JMBaseProject
//
//  Created by 潘传标 on 2019/9/6.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "IntegraMallListCell.h"

@interface IntegraMallListCell ()

@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *integralLabel;
@property (weak, nonatomic) IBOutlet UILabel *exchangeCountLabel;

@end


@implementation IntegraMallListCell

-(void)setCellData:(IntegralGoodModel *)cellData{
    _cellData = cellData;
    [self.coverImageView sd_setImageWithURL:[JMCommonMethod imageUrlWithPath:self.cellData.coverImage]];
    self.nameLabel.text = self.cellData.name;
    self.integralLabel.text = [NSString stringWithFormat:@"%@积分",self.cellData.exchangeIntegral];
    self.exchangeCountLabel.text = [NSString stringWithFormat:@"已兑换%@",self.cellData.exchangeCount];
}

@end
