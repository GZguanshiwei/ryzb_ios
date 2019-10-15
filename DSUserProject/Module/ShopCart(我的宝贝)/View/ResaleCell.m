//
//  ResaleCell.m
//  JMBaseProject
//
//  Created by Liuny on 2019/6/19.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "ResaleCell.h"

@interface ResaleCell ()
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *profitLabel;//利润

@end

@implementation ResaleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initControl];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)initControl{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(void)setCellData:(GoodModel *)cellData{
    _cellData = cellData;
    [self.coverImageView sd_setImageWithURL:[JMCommonMethod imageUrlWithPath:self.cellData.coverImage]];
    self.titleLabel.text = self.cellData.title;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",self.cellData.resalePrice];
    float liRun = self.cellData.resalePrice.doubleValue - self.cellData.price.doubleValue;
    self.profitLabel.text = [NSString stringWithFormat:@"(利润￥%.2f)",liRun];
}

#pragma mark - Actions

- (IBAction)moreAction:(id)sender {
    if(self.delegate && [self.delegate respondsToSelector:@selector(didMoreOperation:)]){
        [self.delegate didMoreOperation:self.index];
    }
}

- (IBAction)buyAction:(id)sender {
    if(self.delegate && [self.delegate respondsToSelector:@selector(didBuy:)]){
        [self.delegate didBuy:self.index];
    }
}

- (IBAction)customerServiceAction:(id)sender{
    if(self.delegate && [self.delegate respondsToSelector:@selector(didCustomerService:)]){
        [self.delegate didCustomerService:self.index];
    }
}

- (IBAction)shareAction:(id)sender {
    if(self.delegate && [self.delegate respondsToSelector:@selector(didShare:)]){
        [self.delegate didShare:self.index];
    }
}

@end
