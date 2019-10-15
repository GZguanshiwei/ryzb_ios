//
//  MarketShopCell.m
//  JMBaseProject
//
//  Created by Liuny on 2019/6/19.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "MarketShopCell.h"

@interface MarketShopCell ()
@property (weak, nonatomic) IBOutlet UIView *imageMainView;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UIButton *storeButton;
@property (weak, nonatomic) IBOutlet UIButton *resaleButton;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@end

@implementation MarketShopCell

-(void)awakeFromNib{
    [super awakeFromNib];
    [self initControl];
}

-(void)initControl{
    self.imageMainView.layer.cornerRadius = 7.0;
    self.imageMainView.layer.masksToBounds = YES;
}

-(void)setCellData:(GoodModel *)cellData{
    _cellData = cellData;
    [self.coverImageView sd_setImageWithURL:[JMCommonMethod imageUrlWithPath:self.cellData.coverImage]];
    self.storeButton.selected = self.cellData.isCollected;
    [self.storeButton setTitle:[NSString stringWithFormat:@" %@",self.cellData.collectedNum] forState:UIControlStateNormal];
    [self.resaleButton setTitle:[NSString stringWithFormat:@" %@",self.cellData.resaleNum] forState:UIControlStateNormal];
    self.titleLabel.text = self.cellData.title;
    self.dateLabel.text = [cellData.time substringToIndex:10];
    NSString *price = [NSString stringWithFormat:@"￥%@",self.cellData.price];
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:price];
    [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15 weight:UIFontWeightBold] range:NSMakeRange(0, 1)];
    self.priceLabel.attributedText = attriStr;
}

#pragma mark - Actions
- (IBAction)resaleAction:(id)sender {
    if(self.delegate && [self.delegate respondsToSelector:@selector(didResale:)]){
        [self.delegate didResale:self.index];
    }
}

- (IBAction)storeAction:(id)sender {
    if(self.delegate && [self.delegate respondsToSelector:@selector(didStore:)]){
        [self.delegate didStore:self.index];
    }
}
@end
